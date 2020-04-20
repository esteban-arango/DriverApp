require './config/environment'
require './lib/jwt_auth'

class ApplicationController < Sinatra::Base
  use JwtAuth

  get "/" do
    content_type :json
    { message: "Hello, World!" }.to_json
  end
end


