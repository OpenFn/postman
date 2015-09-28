require 'receipts'

describe Receipts do

  def app
    described_class
  end

  context 'GET' do

    let(:receipt) { {id: "__RECEIPT_UUID__", body: "__POST_BODY__", mapping_id: 10} }

    context 'with valid receipt id' do

      before :each do
        expect(ReceiptRecord).to receive(:[]).with(id: receipt[:id]).
          and_return receipt
      end

      it 'returns the receipt body' do
        get "/#{receipt[:id]}"
        expect(last_response.status).to eql 200
        expect(last_response.body).to eql receipt[:body]
      end

      context 'transform' do

        let(:jolt_result) { "__JOLT_RESULT__" }
        let(:payload) { "__PAYLOAD__" }

        it "sends the receipt to Jolt and returns the result" do
          expect(JoltPayloadFactory).to receive(:new).with(receipt[:id]).
            and_return double("JoltPayloadFactory", payload: payload)
          expect(JoltService).to receive(:shift).with(payload: payload).
            and_return jolt_result

          get "/#{receipt[:id]}/transform"
          expect(last_response.status).to eql 200
          expect(last_response.body).to eql jolt_result
        end
        
      end
      
    end

    context 'with invalid receipt id' do

      it 'returns 404' do
        expect(ReceiptRecord).to receive(:[]).with(id: receipt[:id]).
          and_return nil

        get "/#{receipt[:id]}"

        expect(last_response.status).to eql 404
      end
      
    end
    
  end
  
end
