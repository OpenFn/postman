module Consequential
  class CommandHandler

    class << self
      def on(command_class, &block)
        CommandService.register(command_class, block)
      end

    end
  end
end
