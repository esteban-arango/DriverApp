require_relative "spec_helper"

def app
  ApplicationController
end

describe ApplicationController do
  it "respond success" do
    get '/'
    expect(last_response.status).to eq(200)
  end
end
