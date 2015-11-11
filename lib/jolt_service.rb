require 'faraday'
require 'json'

class JoltService
  API = Faraday.new(:url => ENV['JOLT_SERVICE_URL'], request: {timeout: 30}) do |faraday|
    faraday.request  :url_encoded  
    faraday.response :logger                  # log requests to STDOUT
    faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
  end

  class << self
    def shift(input:, specs:)
      response = API.post('/shift', {input: input,specs: specs}.to_json)
      raise Exception unless response.success?
      JSON.parse(response.body)
    end
  end
end
