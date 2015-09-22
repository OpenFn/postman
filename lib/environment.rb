require 'rubygems'
require 'bundler'

ENV['ENV'] ||= "development"
ENV['DATABASE_URL']  ||= "postgres://localhost/postman"

Bundler.require(:default, :test)

Sequel.connect(ENV['DATABASE_URL'])

$:.unshift File.dirname(__FILE__)
