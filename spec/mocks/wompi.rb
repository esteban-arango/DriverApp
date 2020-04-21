RSpec.configure do |config|
  config.before(:each) do
    headers = {
      'Accept' => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Content-Type' => 'application/json',
      'User-Agent' => 'Ruby'
    }
    stub_request(:post, ENV['WOMPI_HOST'] + 'tokens/cards')
      .with(headers: headers)
      .to_return(status: 200, body: {
        status: 'CREATED',
        data: { id: 'token_wyOHYZ5z90b3zH2yrWjETfOJkB', name: 'VISA-4242', brand: 'VISA', last_four: '4242', card_holder: 'Pedro Pérez' }
      }.to_json, headers: { 'Content-Type' => 'application/json' })

    stub_request(:get, ENV['WOMPI_HOST'] + "merchants/#{ENV['WOMPI_PUB_TOKEN']}")
      .with(headers: headers)
      .to_return(status: 200, body: {
        data: { presigned_acceptance: { acceptance_token: 'token_wyOHYZ5z90b3zH2yrWjETfOJkB' } }
      }.to_json, headers: { 'Content-Type' => 'application/json' })

    stub_request(:post, ENV['WOMPI_HOST'] + 'transactions')
      .with(headers: headers)
      .to_return(status: 200, body: {
        data: { status: 'APPROVED' }
      }.to_json, headers: { 'Content-Type' => 'application/json' })
  end
end
