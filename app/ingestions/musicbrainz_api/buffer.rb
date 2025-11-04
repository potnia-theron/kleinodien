module MusicbrainzApi
  class Buffer
    def initialize(api, cache: {})
      @api = api
      @cache = cache
    end

    def get(uri)
      cache[uri] ||= api.get(uri)
    end

    private

    attr_reader :api, :cache
  end
end
