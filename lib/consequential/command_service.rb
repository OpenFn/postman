module Consequential
  class CommandService
    CommandListener = Struct.new(:command_class,:proc)

    class << self
      def register(command_class, block)
        @listeners ||= []
        @listeners << CommandListener.new(command_class, block)
      end

      def execute(command)
        
        @listeners.select { |listener| listener.command_class == command.class }.
          each { |listener|
          Log.debug "#{command.class.name} (#{ command.inspect })-> #{listener.command_class.name}"
            listener.proc[command] 
        }
      end
    end
  end
end
