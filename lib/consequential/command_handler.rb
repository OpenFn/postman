module Consequential
  class CommandHandler

    class << self
      def on(command_class, &block)
        CommandService.register(command_class, block)
      end

      def with_aggregate(aggregate, &block)
        yield aggregate
      end

    end
  end
end
