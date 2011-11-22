module FlashS3
  class AttachmentDefinition
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def valid?
      bucket.present?
    end

    def configure(&blk)
      instance_eval(&blk)
    end

    def bucket(*args)
      val, *_ = args
      @bucket = val if val
      @bucket || FlashS3.configuration.bucket
    end
  end
end
