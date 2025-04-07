module Import
  class MusicbrainzRequestLayer
    def initialize(order)
      @order = order
    end

    attr_reader :order
    delegate_missing_to :order

    def get(kind, code)
      kind = kind.to_s.dasherize

      uri_string = uri_string_for(kind, code)
      buffer.fetch(uri_string) { fetch_layer.get(uri_string) }
    end

    def uri_string_for(kind, code)
      uri_builder.call(kind, code)
    end

    def uri_builder = @uri_builder ||= Import::MusicbrainzUriBuilder.new

    def buffer
      @buffer ||= Import::Buffer.new(order)
    end

    def fetch_layer
      @fetch_layer ||= build_fetch_layer
    end
  end
end
