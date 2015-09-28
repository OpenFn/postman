require 'rubygems'
require 'bundler'

ENV['ENV'] ||= "development"
ENV['DATABASE_URL']  ||= "postgres://localhost/postman"
ENV['JOLT_SERVICE_URL'] ||= "http://jolt-api.dev/"

Bundler.require(:default, :test)

Sequel.connect(ENV['DATABASE_URL'])

$:.unshift File.dirname(__FILE__)
