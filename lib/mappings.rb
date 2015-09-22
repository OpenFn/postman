require 'mappings/records'
require 'json'

class Mappings < Roda

  route do |r|

    response[ 'Content-Type' ] = "application/json"

    r.post do
      params = JSON.parse( request.body.read )

      begin
        @mapping = MappingRecord.create(params)
        response.status = 201
        @mapping.to_json
      rescue Sequel::NotNullConstraintViolation
        response.status = 406
      end

    end
  end
end
