require 'mappings/records'
require 'receipts/records'

# JoltPayloadFactory.new(receipt_id).payload
# Leveraging Postgres we can return a valid Jolt API JSON message straight
# from the database. This way we have minimal coupling on Jolt, as 
# this will shortly be DEPRECATED.

class JoltPayloadFactory

  JoltMap = Sequel.lit(%Q[
    json_build_object(
      'input', body::json,
      'specs', jolt_spec::json
    )
  ])

  def initialize(receipt_id)
    @query = ReceiptRecord.
      join(MappingRecord, id: :mapping_id).
      where(receipts__id: receipt_id).
      select(JoltMap.as(:payload)).
      first
  end

  def payload
    @query[:payload]
  end
end
