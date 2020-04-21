require './config/environment'
require './lib/jwt_auth'
require './app/contracts/ride_contract.rb'

class DriverController < Sinatra::Base
  use Rack::PostBodyContentTypeParser
  use JwtAuth

  before do
    content_type :json
  end

  post '/v1/finish_ride' do
    result = GetRideContract.new.call(params)
    if result.success? && env[:user].class.name == 'Driver'
      { message: env[:user].finish_ride(result.to_h) }.to_json
    else
      response = result.errors.to_h
      if env[:user].class.name != 'Driver'
        response.merge({ token: 'Token is not for Drivers, check your token' })
      end
      halt 422, { message: response }.to_json
    end
  end
end
