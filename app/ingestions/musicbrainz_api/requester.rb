module MusicbrainzApi
  class Requester
    def initialize(api, closeable, uri_builder)
      @api = api
      @closeable = closeable
      @uri_builder = uri_builder
    end

    def get(...)
      uri = build_uri(...)
      api.get(uri)
    end

    delegate :close!, :closed?, to: :closeable

    private

    attr_reader :api, :closeable, :uri_builder

    def build_uri(...) = uri_builder.build(...)
  end
end
