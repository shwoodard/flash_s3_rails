require 'rspec'
require 'flash_s3'

include FlashS3

RSpec.configure do |config|
  config.after(:each) do
    ::FlashS3.configuration.clear
  end
end
