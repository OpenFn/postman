require 'mappings/records'
require 'mappings/commands'
require 'json'

class Mappings < Roda

  plugin :all_verbs

  route do |r|

    response[ 'Content-Type' ] = "application/json"

    r.post do
      command = CreateMappingCommand.new JSON.parse( request.body.read )

      begin
        @mapping = MappingRecord.create(command.assigned_attributes)
        response.status = 201
        @mapping.values.to_json
      rescue Sequel::NotNullConstraintViolation
        response.status = 406
      end

    end

    r.on :id do |id|
      @mapping = MappingRecord[id: id]

      r.on !!@mapping do
        r.patch do
          command = UpdateMappingCommand.new JSON.parse( request.body.read )

          @mapping.update(command.assigned_attributes)
          response.status = 202
        end
      end

    end
  end
end
