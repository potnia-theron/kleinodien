module Import
  class DomainBuffer
    def initialize(buffer, domain_key)
      @buffer = buffer
      @domain_key = domain_key.to_s
    end

    def fetch(*cache_key_parts, &block)
      buffer.fetch(domain_key, cache_key_parts, &block)
    end

    private

    attr_reader :buffer, :domain_key
  end
end
