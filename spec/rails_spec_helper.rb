ENV['RAILS_ENV'] ||= 'test'

require 'flash_s3_test/rails/flash_s3_test/config/environment'
require 'capybara/dsl'
require 'database_cleaner'

include Capybara::DSL

Capybara.app = Rack::Builder.app do
  run FlashS3Test::Application
end

Capybara.server do |app, port|
  require 'rack/handler/mongrel'
  Rack::Handler::Mongrel.run(app, :Port => port)
end

Capybara.default_driver = :selenium

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

