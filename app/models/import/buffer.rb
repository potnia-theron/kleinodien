module Import
  class Buffer
    def fetch(domain_key, *, &block)
      domain_cache = domain_cache_for(domain_key)
      cache_key = cache_key_for(*)

      domain_cache[cache_key] = block.call if block
      domain_cache[cache_key]
    end

    def musicbrainz
      Import::DomainBuffer.new(self, "musicbrainz.org")
    end

    private

    def cache
      @cache ||= {}
    end

    def domain_cache_for(domain_key)
      cache[domain_key.to_s] ||= {}
    end

    def cache_key_for(*cache_key_parts)
      raise ArgumentError, "can't build a cache_key without values" if cache_key_parts.empty?
      cache_key_parts.map(&:to_s).join("/")
    end
  end
end
