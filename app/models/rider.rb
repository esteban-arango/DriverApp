require './app/models/user.rb'
require './lib/wompi'

class Rider < User
  has_many :payment_sources
  has_many :rides

  def create_payment_source(params)
    response = Wompi.tokenize_credit_card(params)
    response['token'] = response['id'] # rename id tokenized
    payment_fields = response.slice('token', 'name', 'brand', 'last_four', 'card_holder')

    payment_sources.create(payment_fields)
  end

  def create_ride(params)
    rides.create(params)
  end
end
