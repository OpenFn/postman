require 'virtus'

class Json < Virtus::Attribute
  def coerce(value)
    value.is_a?(::Hash) ? JSON.generate(value) : value
  end
end


class CreateMappingCommand
  include Virtus.model

  attribute :id, String
  attribute :jolt_spec, Json, default: nil
  attribute :title, String

  def assigned_attributes
    attributes.select { |k,v| !!v }
  end
end

class UpdateMappingCommand
  include Virtus.model

  attribute :id, String
  attribute :jolt_spec, Json, default: nil
  attribute :title, String

  def assigned_attributes
    attributes.select { |k,v| !!v }
  end
end
