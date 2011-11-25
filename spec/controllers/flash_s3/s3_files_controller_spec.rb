require 'spec_helper'
require 'rails_spec_helper'

describe FlashS3::S3FilesController do
  context 'create with POST' do
    it 'should respond with json' do
      post :create, :s3_file_class => "Upload", :upload => {:upload => {:s3_key => 'fubar'}}, :format => :json

      response.should be_success

      Upload.first.upload_s3_key.should == "fubar"
    end
  end
end
