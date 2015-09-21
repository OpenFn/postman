require 'rubygems'
require 'bundler'

ENV['ENV'] ||= "development"
ENV['PG_URL']  ||= "postgres://localhost/postman"

Bundler.require(:default, :test)

Sequel.connect(ENV['PG_URL'])

$:.unshift File.dirname(__FILE__)
