require 'faraday'
require 'json'

ENV['JOLT_SERVICE_URL'] ||= "http://localhost:9292/"

class JoltService
  API = Faraday.new(:url => ENV['JOLT_SERVICE_URL']) do |faraday|
    faraday.request  :url_encoded  
    faraday.response :logger                  # log requests to STDOUT
    faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
  end

  class << self
    def shift(spec,input)
      API.post('/shift', { spec: spec, input: input }).body
    end
  end
end
