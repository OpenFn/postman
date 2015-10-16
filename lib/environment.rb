require 'rubygems'
require 'bundler'
require 'logger'

# Configuration Defaults
ENV['ENV']              ||= "development"
ENV['DATABASE_URL']     ||= "postgres://localhost/postman"
ENV['JOLT_SERVICE_URL'] ||= "http://jolt-api.dev/"

# Logging
Log = Logger.new(STDOUT)
Log.level = Logger::DEBUG

Bundler.require(:default, ENV['ENV'])

# Database
DB = Sequel.connect(ENV['DATABASE_URL'])
DB.loggers << Log
DB.extension :pg_json

$:.unshift File.dirname(__FILE__)

# Components
require 'inboxes'
require 'receipts'
require 'events'
require 'jobs'
require 'submissions'
