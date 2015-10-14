require 'receipts'
require 'events'
require 'submissions'
require 'jolt_service'

class InboxAPI < Roda

  route do |r|

    response[ 'Content-Type' ] = "application/json"

    r.on :inbox_id do |inbox_id|
      r.post do

        # -> Receipt Arrived
        #   * Store Receipt
        #     - Receipt Stored

        Log.debug "Receipt Arrived"
        # TODO: Persist Receipts
        # receipt = ReceiptRecord.create({
        #   inbox_id: mapping_id,
        #   body: request.body.read
        # })

        # -> Receipt Stored
        #   * Match Receipt
        #     | Find Policies for Inbox
        #     | Test Policies for Receipt
        #     - Receipt Matched
        #     - Receipt Not Matched

        receipt = Receipt::Record.new(
          body: request.body.read,
          inbox_id: inbox_id
        )
        receipt.save

        Log.debug "Receipt Stored"

        Log.debug "Match Receipt"
        Log.debug "Finding Events for Inbox"
        triggers = Event::Definition.by_matched_criteria(receipt)

        Log.debug "Found #{triggers.count} Events for Inbox##{inbox_id}"

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

        response.status = 202

        # TODO: return the receipt id
        # {
        #   "@id"=> (Pathname.new(request.base_url) + "receipts/#{receipt[:id]}")
        # }.to_json
      end

    end
  end
end
