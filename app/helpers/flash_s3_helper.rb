module FlashS3Helper
  def flash_s3_uploader(record, attachment, options = {})
    render :partial => 'flash_s3/flash_s3_uploader.html', :locals => {
      :id => uploader_id(record, attachment),
      :button_id => uploader_button_id(record, attachment),
      :swf_upload_options_as_json => swf_upload_options_as_json(record, attachment, options)
    }
  end

  def swf_upload_options_as_json(record, attachment, options)
    {
      :flash_url                => "/assets/vendor/flash_s3/swfupload.swf",
      :button_placeholder_id    => uploader_button_id(record, attachment),
      :button_width             => 61,
      :button_height            => 22
    }.to_json
  end

  def uploader_id(record, attachment)
    "#{record.class.name.underscore.downcase}_#{attachment}"
  end

  def uploader_button_id(record, attachment)
    "#{uploader_id(record, attachment)}-flash_s3-button"
  end
end
