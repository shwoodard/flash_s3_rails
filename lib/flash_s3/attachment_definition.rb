module FlashS3
  class AttachmentDefinition
    REQUIRED_FIELDS = %w{bucket s3_access_key_id s3_secret_access_key}
    OPTIONAL_FIELDS = {
      's3_bucket_acl' => 'public-read',
      's3_key_guid' => lambda { SecureRandom.hex },
      's3_key_path' => ''
    }

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def valid?
      (REQUIRED_FIELDS + OPTIONAL_FIELDS.keys).none? {|field| send(field).nil? }
    end

    def configure(&blk)
      instance_eval(&blk)
    end

    def optional_field_default_value(field)
      if field_val = OPTIONAL_FIELDS[field]
        field_val.respond_to?(:call) ? field_val.call : field_val
      end
    end

    (REQUIRED_FIELDS + OPTIONAL_FIELDS.keys).each do |field|
      eval <<-EVAL
        def #{field}(*args)
          val, *_ = args
          @#{field} = val if val
          @#{field} || FlashS3.configuration.#{field}#{" || optional_field_default_value('#{field}')" if OPTIONAL_FIELDS.keys.include?(field)}
        end
      EVAL
    end
  end
end
