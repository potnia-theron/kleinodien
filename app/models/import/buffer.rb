class Import::Buffer
  class DomainBuffer
    def initialize(buffer, domain_key)
      @buffer = buffer
      @domain_key = domain_key
    end

    attr_reader :buffer, :domain_key

    def fetch(*cache_key_parts, &block)
      buffer.fetch("musicbrainz.org", cache_key_parts, &block)
    end
  end

  def fetch(domain_key, *cache_key_parts, &block)
    cache_key = cache_key_for(cache_key_parts)

    cache[cache_key] = block.call if block
    cache[cache_key]
  end

  def musicbrainz
    DomainBuffer.new(self, "musicbrainz.org")
  end

  private

  def cache
    @cache ||= {}
  end

  def cache_key_for(*cache_key_parts)
    raise ArgumentError, "can't build a cache_key without values" if cache_key_parts.empty?
    cache_key_parts.map(&:to_s).join("/")
  end
end
