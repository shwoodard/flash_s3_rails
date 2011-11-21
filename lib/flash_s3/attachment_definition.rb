module FlashS3
  class AttachmentDefinition
    attr_accessor :attachment, :bucket
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def valid?
      bucket.present?
    end

    def configure
      yield(configuration)
    end

    private

    def configuration
      @configuration ||= FlashS3.configuration
    end
  end
end
