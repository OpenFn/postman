require 'inboxes'

module Receipt

  class Record < Sequel::Model(:receipts)
    many_to_one :inbox, class: "Inbox"
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
