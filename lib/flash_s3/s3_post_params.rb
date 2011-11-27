module FlashS3
  class S3PostParams
    def initialize(record, name)
      @attachment_definition = record.send(name).attachment_definition
    end

    def params
      {
        "key" => s3_key,
        "AWSAccessKeyId" => "#{s3_access_key_id}",
        "acl" => "#{s3_bucket_acl}",
        "policy" => "#{s3_policy}",
        "signature" => "#{s3_signature}",
        "success_action_status" => "201"
      }
    end

    def s3_policy
      @policy ||= Base64.encode64(
        %Q%{'expiration': '#{expiration_date}',
          'conditions': [
          {'bucket': 'grtvdev'},
          ['starts-with', '$key', "#{ s3_key_path.present? ? s3_key_path : ''}"],
          {'acl': '#{s3_bucket_acl}'},
          {'success_action_status': '201'},
          ['content-length-range', 0, #{max_file_size}],
          ['starts-with', '$Filename', '']
          ]
          }%
      ).gsub(/\n|\r/, '')
    end

    def s3_signature
      Base64.encode64(
        OpenSSL::HMAC.digest(
        OpenSSL::Digest::Digest.new('sha1'),
        s3_secret_access_key, s3_policy)
      ).gsub("\n","")  
    end

    def s3_access_key_id
      @attachment_definition.s3_access_key_id
    end

    def s3_secret_access_key
      @attachment_definition.s3_secret_access_key
    end

    def expiration_date
      1.hour.from_now.utc.strftime('%Y-%m-%dT%H:%M:%S.000Z')
    end

    def max_file_size
      20.megabytes
    end

    def s3_bucket_acl
      @attachment_definition.s3_bucket_acl
    end

    def s3_key_guid
      @attachment_definition.s3_key_guid
    end

    def s3_key_path
      @attachment_definition.s3_key_path
    end

    def s3_key
      key = "${filename}"
      key = "#{s3_key_guid}_" + key if s3_key_guid.present?
      key = "#{s3_key_path}/" + key if s3_key_path.present?
      key
    end
  end
end
