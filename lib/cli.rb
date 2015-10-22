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
        when "job:show"
          JobCommand.new(@arguments, @host).show
        when "receipt:show"
          ReceiptCommand.new(@arguments, @host).show
        when "receipt:process"
          ReceiptCommand.new(@arguments, @host).process
        when "submission:show"
          SubmissionCommand.new(@arguments, @host).show
        when "inbox:autoprocess:on"
          InboxCommand.new(@arguments, @host).enable_autoprocess
        when "inbox:autoprocess:off"
          InboxCommand.new(@arguments, @host).disable_autoprocess
        else
          raise "Unrecognized command."
        end

      rescue Exception => e
        puts e
        puts e.backtrace.join("\n")
        exit 1
      end

      exit 0
    end

    class ReceiptCommand
      def initialize(arguments, host)
        @host = host
        @arguments = arguments
      end

      def show
        id = @arguments.first

        if id
          response = connection.get "/receipts/#{id}"

          raise "Receipt not found." if response.status == 404
          puts response.body
        end
      end

      def process

        id = @arguments.first

        if id
          response = connection.post "/receipts/#{id}/process"

          raise "Receipt not found." if response.status == 404
          puts response.body

        else
          raise "Please provide an ID for a receipt."
        end

      end

      private

      def connection
        Faraday.new(url: @host) do |faraday|
          faraday.headers["Accept"] = "text/plain"
          faraday.adapter  Faraday.default_adapter
        end
      end
    end

    class SubmissionCommand
      def initialize(arguments, host)
        @host = host
        @arguments = arguments
      end

      def show
        id = @arguments.first

        if id

          response = connection.get "/submissions/#{id}"

          raise "Receipt not found." if response.status == 404
          puts response.body
        end

      end

      private

      def connection
        Faraday.new(url: @host) do |faraday|
          faraday.headers["Accept"] = "text/plain"
          faraday.adapter  Faraday.default_adapter
        end
      end

    end

    class JobCommand
      def initialize(arguments, host)
        @host = host
        @arguments = arguments
      end

      def show
        id = @arguments.first

        if id

          response = connection.get "/job_roles/#{id}"

          raise "Receipt not found." if response.status == 404
          puts response.body
        end

      end

      private

      def connection
        Faraday.new(url: @host) do |faraday|
          faraday.headers["Accept"] = "text/plain"
          faraday.adapter  Faraday.default_adapter
        end
      end

    end

    class InboxCommand
      def initialize(arguments, host)
        @host = host
        @arguments = arguments
      end

      def enable_autoprocess
        id = @arguments.first

        if id

          response = connection.patch "/inbox/#{id}", autoprocess: true

          raise "Inbox not found." if response.status == 404
          puts response.body
        end

      end

      def disable_autoprocess
        id = @arguments.first

        if id

          response = connection.patch "/inbox/#{id}", autoprocess: false

          raise "Inbox not found." if response.status == 404
          puts response.body
        end

      end

      private

      def connection
        Faraday.new(url: @host) do |faraday|
          faraday.request  :url_encoded
          faraday.headers["Accept"] = "text/plain"
          faraday.adapter  Faraday.default_adapter
        end
      end

    end
  end
end
