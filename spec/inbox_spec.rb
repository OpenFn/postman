require 'inbox'

describe Inbox do

  def app
    described_class
  end

  context 'POST' do

    let(:mapping) { {id: "__UUID__"} }
    let(:body) { "__POST_BODY__" }

    context 'with valid mapping uuid' do

      it 'returns the receipt uuid' do
        expect(MappingRecord).to receive(:[]).with(id: mapping[:id]).
          and_return mapping
        expect(ReceiptRecord).to receive(:create).with({
          mapping_id: mapping[:id],
          body: body
        })
        post "/inbox/#{mapping[:id]}", body
        expect(last_response.status).to eql 202
      end
      
    end

    context 'with invalid mapping uuid' do

      it 'returns 404' do
        expect(MappingRecord).to receive(:[]).with(id: mapping[:id]).
          and_return nil
        expect(ReceiptRecord).to_not receive(:create)

        post "/inbox/#{mapping[:id]}", body

        expect(last_response.status).to eql 404
      end
      
    end
    
  end
  
end
