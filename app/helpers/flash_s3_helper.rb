module FlashS3Helper
  def flash_s3_uploader(record, attachment, options = {})
    render :partial => 'flash_s3/flash_s3_uploader.html', :locals => {
      :id => uploader_id(record, attachment),
      :button_id => uploader_button_id(record, attachment),
      :swf_upload_options_as_json => swf_upload_options_as_json(record, attachment, options)
    }
  end

  def swf_upload_options_as_json(record, attachment, options)
    s3_post_params = FlashS3::S3PostParams.new(record, attachment)
    attachment_defintion = record.send(attachment).attachment_definition
    {
      :upload_url            => "http://#{attachment_defintion.bucket}.s3.amazonaws.com/",
      :flash_url             => "/assets/vendor/flash_s3/swfupload.swf",
      :post_params           => s3_post_params.params,
      :button_placeholder_id => uploader_button_id(record, attachment),
      :button_width          => 60,
      :button_height         => 28,
      :button_image_url      => "/assets/vendor/flash_s3/upload_button.png",
      :button_cursor         => -2,
      :http_success          => [ 200, 201, 204 ],
      :file_post_name        => "file",
      :custom_settings => {
        :record_class_name        => record.class.name.underscore.downcase,
        :attachment_name          => attachment.to_s,
        :create_s3_attachment_url => flash_s3_s3_files_url
      }
    }.to_json
  end

  def uploader_id(record, attachment)
    "#{record.class.name.underscore.downcase}_#{attachment}"
  end

  def uploader_button_id(record, attachment)
    "#{uploader_id(record, attachment)}-flash_s3-button"
  end
end
