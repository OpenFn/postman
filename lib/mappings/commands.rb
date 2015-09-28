require 'json'
require 'virtus'

class Json < Virtus::Attribute
  def coerce(value)
    return if value.nil?
    value.is_a?(String) ? value : JSON.generate(value)
  end
end


class CreateMappingCommand
  include Virtus.model

  attribute :id, String
  attribute :jolt_spec, Json
  attribute :destination_schema, Json
  attribute :destination_configuration, Json
  attribute :title, String

  def assigned_attributes
    attributes.select { |k,v| !!v }
  end
end

class UpdateMappingCommand
  include Virtus.model

  attribute :id, String
  attribute :jolt_spec, Json
  attribute :destination_schema, Json
  attribute :destination_configuration, Json
  attribute :title, String

  def assigned_attributes
    attributes.select { |k,v| !!v }
  end
end

