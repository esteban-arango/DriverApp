ENV['SINATRA_ENV'] ||= 'development'
ENV['JWT_SECRET']  ||= 'NPWLBuvLdmVXDEOwyOHYZ5z90b3zH2yrWjETfOJkBQ3boo_SV5'
ENV['JWT_ISSUER']  ||= 'www.driverapp.com'
ENV['WOMPI_HOST']  ||= 'https://sandbox.wompi.co/v1/'
ENV['WOMPI_PUB_TOKEN'] ||= 'pub_test_uqC4gbpjVAbAoFv5WvSrDyQDPMov4M6r'
ENV['WOMPI_PRV_TOKEN'] ||= 'prv_test_3Q1CqsIYK2YTFJNRTSQFu9KgJ0B9AQwr'


require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

#ActiveRecord::Base.establish_connection(
#  :adapter => 'sqlite3',
#  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
#)

Dir['./app/controllers/*.rb'].each {|file| require file }
require 'rack/contrib'
require 'sinatra/base'

require_all 'app'
