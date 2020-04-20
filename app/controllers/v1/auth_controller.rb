require 'bcrypt'
require './app/contracts/auth_contract.rb'

class AuthController < Sinatra::Base
  use Rack::PostBodyContentTypeParser

  post '/auth_token' do
    result = AuthContract.new.call(params)
    if result.success?
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        content_type :json
        { token: token(params[:email]) }.to_json
      else
        halt 401, { message: 'Invalid Credentials' }.to_json
      end
    else
      halt 422, { message: result.errors.to_h }.to_json
    end
  end

  def token email
    JWT.encode payload(email), ENV['JWT_SECRET'], 'HS256'
  end

  def payload email
    {
      exp: Time.now.to_i + 60 * 60,
      iat: Time.now.to_i,
      iss: ENV['JWT_ISSUER'],
      scopes: ['*'],
      user: {
        email: email
      }
    }
  end
end
