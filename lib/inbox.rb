require 'receipts'
require 'events'
require 'submissions'
require 'jolt_service'

class InboxAPI < Roda

  route do |r|

    response[ 'Content-Type' ] = "application/json"

    r.on :inbox_id do |inbox_id|

      @inbox = Inbox.find(id: inbox_id)

      r.on !!@inbox do

        r.post do

          # -> Receipt Arrived
          #   * Store Receipt
          #     - Receipt Stored

          Log.debug "Receipt Arrived"
          @inbox.add_receipt(body: request.body.read)

          # -> Receipt Stored
          #   * Match Receipt
          #     | Find Policies for Inbox
          #     | Test Policies for Receipt
          #     - Receipt Matched
          #     - Receipt Not Matched

          Log.debug "Receipt Stored"

          response.status = 200

          # TODO: return the receipt id
          # {
          #   "@id"=> (Pathname.new(request.base_url) + "receipts/#{receipt[:id]}")
          # }.to_json
        end

      end

    end
  end
end
