require 'faraday'

module Postman
  class CLI

    attr_reader :argv, :command

    def initialize(argv=[])

      ENV['HOST'] ||= "http://postman.dev"
      @host = ENV['HOST']

      @argv = argv.dup
      @command, *@arguments = argv
    end

    def run

      begin

        case command
        when "receipt:show"
          show
        when "receipt:process"
          process
        else
          raise "Unrecognized command."
        end
          
      rescue Exception => e
        puts e
        exit 1
      end

      exit 0
    end

    private

    def show
      id = @arguments.first

      if id

        conn = Faraday.new(url: @host) do |faraday|
          faraday.headers["Accept"] = "text/plain"
          faraday.adapter  Faraday.default_adapter
        end

        response = conn.get "/receipts/#{id}"

        raise "Receipt not found." if response.status == 404
        puts response.body
      end

    end

    def process
      id = @arguments.first

      if id

        conn = Faraday.new(url: @host) do |faraday|
          faraday.headers["Accept"] = "text/plain"
          faraday.adapter  Faraday.default_adapter
        end

        response = conn.post "/receipts/#{id}/process"

        raise "Receipt not found." if response.status == 404
        puts response.body

      else
        raise "Please provide an ID for a receipt."
      end


    end

  end
end
