require 'inboxes'

module Receipt

  class Record < Sequel::Model(:receipts)
    many_to_one :inbox, class: "Inbox"
    one_to_many :submissions, key: :receipt_id , class: "Submission::Attempt"
  end

  class Matcher
    class << self
      def handle(receipt)
        Log.debug "Match Receipt"
        Log.debug "Finding Events for Inbox"
        triggers = Event::Definition.by_matched_criteria(receipt)

        Log.debug "Found #{triggers.count} Events for Inbox##{receipt.inbox_id}"

        jobs = triggers.map(&:job_roles).flatten

        # -> Receipt Matched
        #   * Create Submission
        #     - Submission Created
        Log.debug "Matched #{jobs.count} Jobs"
        submissions = jobs.collect { |job|
          submission = Submission::Attempt.new({
            receipt: receipt,
            job_role: job
          })
          submission.save
          submission
        }

        submissions.each { |submission| Submission::Processor.handle(submission) }

        # -> Submission Created
        #   * Process Submission
        #     | Execute Steps
        #     - Submission Processed
        #     - Submission Failed Processing

      end
    end
  end

end


# require 'receipts/records'
# require 'receipts/jolt_payload_factory'
# require 'mappings/records'
# require 'jolt_service'
# require 'json'

# class Receipts < Roda

#   plugin :param_matchers

#   route do |r|

#     r.on :id do |id|
#       @receipt = ReceiptRecord[id: id]

#       r.on !!@receipt do

#         # Temporary endpoint for visualising a transformed receipt.
#         # The result of this should be moved shortly to a submission.

#         r.on "transform" do

#           r.get do
#             payload = JoltPayloadFactory.new(@receipt[:id]).payload
#             JoltService.shift(payload: payload)
#           end
#           # r.on param: 'mapping' do |id|
#           #   @mapping = MappingRecord[id: id]

#           #   r.on !!@mapping do
#           #   end
#           # end
#         end

#         r.get do
#           response.status = 200
#           @receipt[:body]
#         end
#       end

#     end
#   end
# end
