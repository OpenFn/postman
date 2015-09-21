require 'mappings/records'
require 'receipts/records'

class Inbox < Roda

  route do |r|
    r.on "inbox" do
      r.on :mapping_uuid do |mapping_uuid|
        @mapping = MappingRecord[id: mapping_uuid]

        r.on !!@mapping do
          r.post do
            ReceiptRecord.create({
              mapping_id: mapping_uuid,
              body: request.body.read
            })
            response.status = 202
          end
        end

      end
    end
  end
end
