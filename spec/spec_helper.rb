require 'rspec'
require 'flash_s3'

include FlashS3

RSpec.configure do |config|
  config.before(:each) do
    @original_bucket = ::FlashS3.configuration.bucket
  end

  config.after(:each) do
    ::FlashS3.configuration.bucket = @original_bucket
  end
end
