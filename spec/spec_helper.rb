ENV['SINATRA_ENV'] = 'test'

require_relative '../config/environment'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/dsl'
require 'webmock/rspec'
Dir['./spec/mocks/*.rb'].each { |rb| require rb }

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate SINATRA_ENV=test` to resolve the issue.'
end

ActiveRecord::Base.logger = nil

FactoryBot.definition_file_paths = %w[./factories ./test/factories ./spec/factories]
FactoryBot.find_definitions
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.include Rack::Test::Methods
  config.include Capybara::DSL
  # DatabaseCleaner.strategy = :truncation

  config.before do
    # DatabaseCleaner.clean
  end

  config.after do
    # DatabaseCleaner.clean
  end

  config.order = 'default'
end

def app
  Rack::Builder.parse_file('config.ru').first
end

Capybara.app = app

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    # Keep as many of these lines as are necessary:
    with.library :active_record
    with.library :active_model
  end
end
