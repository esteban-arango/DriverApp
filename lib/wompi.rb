require 'httparty'

class Wompi
  def self.tokenize_credit_card(body)
    headers = {
      'Authorization' => "Bearer #{ENV['WOMPI_PUB_TOKEN']}",
      'Content-Type' => 'application/json'
    }
    result = HTTParty.post(ENV['WOMPI_HOST'] + 'tokens/cards',
                           body: body.to_json,
                           headers: headers)
    response = nil
    if result.success? && result.parsed_response['status'] == 'CREATED'
      response = { success: true, data: result.parsed_response['data'].symbolize_keys }
    else
      response = { success: false, data: result.parsed_response['error']['messages'] }
    end
    response
  end

  def self.acceptance_token
    headers = { 'Content-Type' => 'application/json' }
    result = HTTParty.get(ENV['WOMPI_HOST'] + "merchants/#{ENV['WOMPI_PUB_TOKEN']}", headers: headers)
    token = ''
    if result.success?
      token = result.parsed_response['data']['presigned_acceptance']['acceptance_token']
    end
    token
  end

  def self.generate_transaction(ride, amount)
    headers = {
      'Authorization' => "Bearer #{ENV['WOMPI_PRV_TOKEN']}",
      'Content-Type' => 'application/json'
    }
    result = HTTParty.post(ENV['WOMPI_HOST'] + 'transactions',
                           body: build_body(ride.payment_source.token, ride.id, ride.rider.email, amount),
                           headers: headers)
    response = nil
    if result.success?
      response = { success: true, data: { id: result.parsed_response['data']['id'], status: result.parsed_response['data']['status'] } }
    else
      response = { success: false, data: result.parsed_response['error']['messages'] }
    end
    response
  end

  def self.get_transaction(id)
    headers = {
      'Authorization' => "Bearer #{ENV['WOMPI_PRV_TOKEN']}",
      'Content-Type' => 'application/json'
    }
    result = HTTParty.get(ENV['WOMPI_HOST'] + "transactions/#{id}", headers: headers)
    response = nil
    response = if result.success?
                 { success: true, data: result.parsed_response['data']['status'] }
               else
                 { success: false, data: result.parsed_response['error']['messages'] }
               end
    response
  end

  def self.build_body(card_token, reference, email, amount)
    {
      acceptance_token: acceptance_token,
      amount_in_cents: amount * 100,
      currency: 'COP',
      customer_email: email,
      payment_method: {
        type: 'CARD',
        token: card_token,
        installments: 2
      },
      # payment_source_id: 0,
      reference: reference.to_s
    }.to_json
  end
end
