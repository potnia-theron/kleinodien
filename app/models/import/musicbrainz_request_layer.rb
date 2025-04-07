module Import
  class MusicbrainzRequestLayer
    def initialize(order, fetch_layer, uri_builder)
      @fetch_layer = fetch_layer
      @order = order
      @uri_builder = uri_builder
    end

    def get(kind, code)
      kind = kind.to_s.dasherize

      uri_string = uri_string_for(kind, code)
      buffer.fetch(uri_string) { fetch_layer.get(uri_string) }
    end

    private

    attr_reader :fetch_layer, :order, :uri_builder

    def uri_string_for(kind, code)
      uri_builder.call(kind, code)
    end

    def buffer
      @buffer ||= Import::Buffer.new(order)
    end
  end
end
