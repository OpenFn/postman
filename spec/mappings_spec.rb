require 'mappings'

describe Mappings do
  def app
    described_class
  end

  context 'POST' do

    let(:mapping) { {
      id: "__MAPPING_UUID__",
      title: "My First Mapping",
      created_at: DateTime.parse("2015-10-31"),
      modified: nil
    } }

    let(:params) { {title: "My First Mapping"} }
    
    context 'with valid params' do

      it 'creates a new mapping' do
        expect(MappingRecord).to receive(:create).with(params).
          and_return(mapping)
        expect(mapping).to receive(:values).and_return(mapping)

        post "/", params.to_json

        expect(last_response.status).to eql 201
        expect(last_response.body).to eql mapping.to_json
      end
      
    end

    context 'with invalid params' do
      
      it 'creates a new mapping' do
        post "/", "{}"

        expect(last_response.status).to eql 406
      end
    end
  end

  context 'PATCH' do

    let(:id) { "__MAPPING_UUID__" }

    let(:mapping) { {
      id: "__MAPPING_UUID__",
      title: "My First Mapping",
      created_at: DateTime.parse("2015-10-31"),
      modified: nil
    } }

    let(:params) { {title: "My New Title"} }

    context 'with valid params' do

      it 'creates a new mapping' do
        expect(MappingRecord).to receive(:[]).with(id: id).
          and_return(mapping)
        expect(mapping).to receive(:update).with(params).
          and_return(mapping)

        patch "/#{id}", params.to_json

        expect(last_response.status).to eql 202
      end
      
    end

    context "when a mapping doesn't exist" do

      it "returns a 404" do
        expect(MappingRecord).to receive(:[]).with(id: id).
          and_return(nil)

        patch "/#{id}", params.to_json

        expect(last_response.status).to eql 404
      end
      
    end


  end
end
