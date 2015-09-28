require 'faraday'
require 'json'

class JoltService
  API = Faraday.new(:url => ENV['JOLT_SERVICE_URL']) do |faraday|
    faraday.request  :url_encoded  
    faraday.response :logger                  # log requests to STDOUT
    faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
  end

  class << self
    def shift(payload:)
      API.post('/shift', payload).body
    end
  end
end
