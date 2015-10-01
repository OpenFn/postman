module Consequential
  class Configuration
    class << self
      attr_accessor :event_service, :command_service
    end
  end
  
end

require 'consequential/event'
require 'consequential/aggregate_root'
require 'consequential/command_service'
require 'consequential/event_service'
require 'consequential/command_handler'
require 'consequential/workflow'
