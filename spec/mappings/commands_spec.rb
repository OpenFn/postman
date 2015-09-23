require 'mappings/commands'

shared_examples "Mapping Commands" do
  
  let(:command_object) { described_class.new(attributes) }

  context 'jolt_spec' do
    let(:attributes) { {jolt_spec: document} }
    let(:document) { {a: 1, b: 2} }

    subject { command_object.jolt_spec }
    it { is_expected.to eql document.to_json }
  end

  context 'destination_schema' do
    let(:attributes) { {destination_schema: document} }
    let(:document) { {a: 1, b: 2} }

    subject { command_object.destination_schema }
    it { is_expected.to eql document.to_json }
  end

end

describe UpdateMappingCommand do
  it_behaves_like "Mapping Commands"
end

describe CreateMappingCommand do
  it_behaves_like "Mapping Commands"
end
