module Consequential
  class EventService
    EventListener = Struct.new(:event_class,:proc)

    class << self
      def register(event_class, block)
        @listeners ||= []
        @listeners << EventListener.new(event_class, block)
      end

      def publish(event)
        
        @listeners.select { |listener| listener.event_class == event.class }.
          each { |listener|
          Log.debug "#{event.class.name} (#{ event.inspect })-> #{listener.event_class.name}"
            listener.proc[event] 
        }
      end
    end
  end
end
