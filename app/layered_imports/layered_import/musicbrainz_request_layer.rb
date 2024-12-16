module LayeredImport
  class MusicbrainzRequestLayer
    def initialize(order)
      @order = order
    end

    attr_reader :order
    delegate_missing_to :order

    def get(kind, code)
      uri_string = uri_string_for(kind, code)
      buffer.fetch(kind, code) { fetch_layer.get(uri_string) }
    end

    def uri_string_for(kind, code)
      "https://musicbrainz.org/ws/2/#{kind}/#{code}?fmt=json"
    end

    def buffer
      @buffer ||= LayeredImport::Buffer.new
    end

    def fetcher
      @fetcher ||= create_fetcher
    end

    def fetch_layer
      @fetch_layer ||= create_fetch_layer
    end
  end
end
