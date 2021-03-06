require './config/environment'
require './lib/jwt_auth'
require './app/contracts/payment_source_contract.rb'

class RiderController < Sinatra::Base
  use Rack::PostBodyContentTypeParser
  use JwtAuth

  before do
    content_type :json
  end

  post '/v1/payment_source' do
    result = PaymentSourceRequestContract.new.call(params)
    if true || result.success?
      create_response = env[:user].create_payment_source(result.to_h)
      code = create_response[:success] ? 200 : 422
      halt code, { message: create_response[:data] }.to_json
    else
      halt 422, { message: result.errors.to_h }.to_json
    end
  end

  post '/v1/request_ride' do
    result = CreateRideContract.new.call(params)
    if result.success?
      { message: env[:user].create_ride(result.to_h) }.to_json
    else
      halt 422, { message: result.errors.to_h }.to_json
    end
  end
end
