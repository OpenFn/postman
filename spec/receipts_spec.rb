require 'receipts'

describe Receipts do

  def app
    described_class
  end

  context 'GET' do

    let(:receipt) { {id: "__RECEIPT_UUID__", body: "__POST_BODY__"} }

    context 'with valid receipt id' do

      it 'returns the receipt body' do
        expect(ReceiptRecord).to receive(:[]).with(id: receipt[:id]).
          and_return receipt

        get "/receipts/#{receipt[:id]}"
        expect(last_response.status).to eql 200
        expect(last_response.body).to eql receipt[:body]
      end
      
    end

    context 'with invalid receipt id' do

      it 'returns 404' do
        expect(ReceiptRecord).to receive(:[]).with(id: receipt[:id]).
          and_return nil

        get "/receipts/#{receipt[:id]}"

        expect(last_response.status).to eql 404
      end
      
    end
    
  end
  
end
