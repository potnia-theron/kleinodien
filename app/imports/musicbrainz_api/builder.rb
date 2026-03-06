module MusicbrainzApi
  class Builder
    def self.build(...)
      new(...).build
    end

    def initialize(import_order, uri_builder)
      @import_order = import_order
      @uri_builder = uri_builder
    end

    def build
      Requester.new(buffer, closeable_api, uri_builder)
    end

    private

    attr_reader :import_order, :uri_builder

    def buffer = Buffer.new(closeable_api)

    def closeable_api
      @closeable ||= Closeable.new(open_api)
    end

    # TODO: rename open_api to fetcher
    def open_api = OpenApi.new(config)

    def config
      @config ||= Rails.configuration&.import&.[](:musicbrainz) || {}
    end
  end
end
