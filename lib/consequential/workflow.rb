module Consequential
  class Workflow 

    class << self
      def on(event_class, &block)
        EventService.register(event_class, block)
      end

      def execute_command(command)
        Consequential::CommandService.execute(command)
      end
    end

  end
end
