require 'receipts/records'
require 'json'

class Receipts < Roda

  route do |r|

    r.on :id do |id|
      @receipt = ReceiptRecord[id: id]

      r.on !!@receipt do
        r.get do
          response.status = 200
          @receipt[:body]
        end
      end

    end
  end
end
