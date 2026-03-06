module MusicbrainzApi
  class Closeable
    def initialize(api)
      @api = api
    end

    def get(uri)
      raise "can't get #{uri} on closed API" if closed?

      api.get(uri)
    end

    def close! = @closed = true

    def closed? = closed

    private

    attr_reader :api, :closed
  end
end
