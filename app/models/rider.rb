require './app/models/user.rb'
require './lib/wompi'

class Rider < User
  has_many :payment_sources
  has_many :rides

  def create_payment_source(params)
    response = Wompi.tokenize_credit_card(params)
    if response[:success]
      response[:data][:token] = response[:data].delete(:id) # rename token key

      result = PaymentSourceContract.new.call(response[:data])
      response = if result.success?
                   { sucess: true, data: payment_sources.create(result.to_h).serialize }
                 else
                   { sucess: false, data: result.errors.to_h }
                 end
    end
    response
  end

  def create_ride(params)
    rides.create(params).serialize
  end
end
