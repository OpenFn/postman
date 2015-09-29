require 'securerandom'
class AggregateRoot

  attr_reader :id

  def initialize(id = SecureRandom.uuid)
    @id = id
  end

  def apply(event)
    Log.debug "#{self.class.name} -> #{event.class.name} (#{event.inspect})"
    DB.transaction do # BEGIN
      DB[:event_store_events].insert({
        stream: id,
        event_type: event.class.name,
        event_id: SecureRandom.uuid,
        data: event.to_json,
        created_at: Time.now
      })
      send "apply_#{event.class.name.snakecase}", event
    end
  end

  class << self

    def on(event_class, &block)
      define_method "apply_#{event_class.name.snakecase}", block
    end

  end

end
