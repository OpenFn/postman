module Consequential
  module Test
    module Matchers

      def self.included(base)
        base.instance_eval {

          RSpec::Matchers.define :be_executed do |expected|
            match do |actual|
              expect(Consequential::CommandService).to receive(:execute).with(actual)
            end
            description do
              "#{expected} to be to have been executed."
            end
          end

          RSpec::Matchers.define :have_been_executed do |expected|
            # match do |actual|
            #   expect(Consequential::CommandService).to receive(:execute).with(actual)
            # end
            # description do
            #   "#{expected} to be to have been executed."
            # end
          end
        }
      end
    end

    module Helpers
      def publish(event)
        Consequential::EventService.publish(event)
      end
    end
  
  end
end
