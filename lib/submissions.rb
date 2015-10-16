module Submission
  class Attempt < Sequel::Model(:submissions)
    many_to_one :receipt, class: "Receipt::Record"
    many_to_one :job_role, class: "Job::Role"
  end

  class LogProxy

    def initialize(submission, tee=STDOUT)
      @submission = submission
      @tee = tee
    end

    def write(data)
      @submission.log << data
      @tee.write(data)
    end

    def close
      @submission.save
    end

  end

  class Processor
    class << self
      def handle(submission)

        begin
          submission.started_at = Time.now
          submission_logger = Logger.new(LogProxy.new(submission))

          job = submission.job_role
          receipt = submission.receipt

          submission_logger.info "Transforming receipt, using '#{job.name}' jolt spec."
          destination_payload = JoltService.shift(input: JSON.parse(receipt.body), specs: job.jolt_spec)

          submission_logger.info "Planning execution for Salesforce."
          plan = Fn::Salesforce.prepare(job.schema.to_h, destination_payload)
          submission_logger.info "Sending resulting payload to Salesforce."

          attributes = job.configuration.to_h
          credentials = Hashie::Mash.new( {
            username:       attributes["username"],
            password:       attributes["password"],
            security_token: attributes["token"],
            client_id:      attributes["key"],
            client_secret:  attributes["secret"],
            host:           attributes["host"]
          }  ).to_hash(symbolize_keys: true)

          Restforce.log = true

          successful = Fn::Salesforce.push(
            credentials, plan, logger: submission_logger
          )

          submission.success = successful
        rescue Exception => e
          submission_logger.error e
          submission.success = false
        end

        submission.finished_at = Time.now
        submission.save

      end
    end
  end


end
