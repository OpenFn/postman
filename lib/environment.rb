require 'rubygems'
require 'bundler'
require 'logger'

ENV['ENV'] ||= "development"
ENV['DATABASE_URL']  ||= "postgres://localhost/postman"
ENV['JOLT_SERVICE_URL'] ||= "http://jolt-api.dev/"

Log = Logger.new(STDOUT)
Log.level = Logger::DEBUG

Bundler.require(:default, :test)

DB = Sequel.connect(ENV['DATABASE_URL'])
DB.loggers << Log
DB.extension :pg_json

$:.unshift File.dirname(__FILE__)
