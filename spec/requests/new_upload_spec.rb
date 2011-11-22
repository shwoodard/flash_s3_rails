require 'spec_helper'
require 'rails_spec_helper'

describe "When uploading a file to s3" do
  it "should boot the app" do
    visit '/'
    page.should have_content("Flash S3")
    page.should have_selector("#upload_upload.flash_s3-wrapper")
  end
end
