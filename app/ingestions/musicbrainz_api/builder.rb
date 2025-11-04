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
      Requester.new(buffer, import_order, uri_builder)
    end

    private

    attr_reader :import_order, :uri_builder

    def buffer = Buffer.new(buffer_api)

    def buffer_api = Closeable.new(open_api)

    def open_api = OpenApi.new(config)

    def config
      @config ||= Rails.configuration&.import&.[](:musicbrainz) || {}
    end
  end
end
