module FlashS3
  class Attachment
    attr_accessor :s3_key

    delegate :bucket, :to => :@definition

    def initialize(name, definition, record)
      @name, @definition, @record = name, definition, record
      self.s3_key = record.send(:"#{name}_s3_key")
    end

    def update(options)
      options.assert_valid_keys(:s3_key)
      options.each do |k,v|
        send(:"#{k}=", v)
        @record.send(:"#{@name}_s3_key=", s3_key)
      end
    end

    def attachment_definition
      @definition
    end

    def valid?
      @definition.valid? && !@record.send(:"#{@name}_s3_key").nil?
    end
  end
end
