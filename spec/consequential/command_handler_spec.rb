require 'consequential'

describe Consequential::CommandHandler do

  describe ".with_aggregate" do

    let(:aggregate) { double(Consequential::Aggregate, touch: true) }
    let(:block) { ->(aggregate) { aggregate.touch } }

    before :each do
    end
    subject { aggregate }
    it "is expected to call the block with the aggregate" do
      expect(subject).to receive(:touch)
      described_class.with_aggregate(aggregate, &block)
    end
  end
  
end
