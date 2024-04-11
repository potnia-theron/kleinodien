module Import
  class SessionAncillary
    def initialize(factory)
      @factory = factory
    end

    delegate :buffered?, to: :buffer

    def deep_dup_buffer
      buffer.deep_dup
    end

    def get(*params)
      buffer.fetch(*params) { build_fetcher(*params).get }
    end

    private

    attr_reader :factory
    delegate_missing_to :factory
  end
end
