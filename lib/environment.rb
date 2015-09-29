require 'rubygems'
require 'bundler'

ENV['ENV'] ||= "development"
ENV['DATABASE_URL']  ||= "postgres://localhost/postman"
ENV['JOLT_SERVICE_URL'] ||= "http://jolt-api.dev/"

Bundler.require(:default, :test)

DB = Sequel.connect(ENV['DATABASE_URL'])


$:.unshift File.dirname(__FILE__)

require 'ext'
require 'logger'
Log = Logger.new(STDOUT)
Log.level = Logger::DEBUG
