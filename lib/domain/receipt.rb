class ReceiveReceiptCommand
  include Virtus::Model

  attribute :inbox_id, String
  attribute :body, String
  attribute :aggregate_id, String, default: ->(id, command) { SecureRandom.uuid }

end


# =================================


class ReceiptCreatedEvent < Consequential::Event
  attr_reader :inbox_id, :body, :id

  def initialize(id:, inbox_id:,body:)
    @id = id
    @inbox_id = inbox_id
    @body = body
  end

  def to_json
    {inbox_id: inbox_id, body: body}.to_json
  end
end

# =================================


class Receipt < Consequential::AggregateRoot

  def self.create(inbox_id:, body:)
    new.tap { |receipt|
      receipt.apply ReceiptCreatedEvent.new({
        id: receipt.id,
        inbox_id: inbox_id,
        body: body
      })
    }
  end

  on ReceiptCreatedEvent do |event|
    @inbox_id = event.inbox_id
    @body = event.body
  end

end

class ReceiveReceiptCommandHandler < Consequential::CommandHandler
  on ReceiveReceiptCommand do |command|
    Receipt.create({ 
      inbox_id: command.inbox_id, body: command.body
    })
  end
end
