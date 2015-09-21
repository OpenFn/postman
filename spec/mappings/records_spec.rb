require 'mappings/records'

describe MappingRecord do

  describe "with_uuid" do
    let(:uuid) { MappingRecord.create(title: "My First Mapping").values[:id] }
    
    subject { MappingRecord[id: uuid].values[:id] }
    it { is_expected.to eql uuid }
  end
  
end
