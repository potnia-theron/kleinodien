module MusicbrainzApi
  class CloseableApi
    def initialize(api)
      @api = api
    end

    def get(uri)
      raise "Bääääää!" if closed?

      api.get(uri)
    end

    def close! = @closed = true

    def closed? = closed

    private

    attr_reader :api, :closed
  end
end
