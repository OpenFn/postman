require 'mappings/records'
require 'receipts/records'

class Inbox < Roda

  route do |r|

    response[ 'Content-Type' ] = "application/json"

    r.on :mapping_id do |mapping_id|
      @mapping = MappingRecord[id: mapping_id]

      r.on !!@mapping do
        r.post do
          receipt = ReceiptRecord.create({
            mapping_id: mapping_id,
            body: request.body.read
          })
          response.status = 202

          {
            "@id"=> (Pathname.new(request.base_url) + "receipts/#{receipt[:id]}")
          }.to_json
        end
      end

    end
  end
end
