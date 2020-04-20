require './config/environment'

class ApplicationController < Sinatra::Base
  get "/" do
    content_type :json
    { message: "Hello, World!" }.to_json
  end
end


