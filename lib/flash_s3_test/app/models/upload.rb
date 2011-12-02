class Upload < ActiveRecord::Base
  has_attached_s3_file :upload
  has_attached_s3_file :upload_with_block do
    bucket 'foo'
    s3_access_key_id 'foo'
    s3_secret_access_key 'fubar'
  end
end
