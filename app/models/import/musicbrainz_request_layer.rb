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
      # if kind.to_s == "release"
      #   "https://musicbrainz.org/ws/2/#{kind}/#{code}?inc=artists+artist-rels+labels+media+recordings+release-groups+url-rels&fmt=json"
      # elsif kind.to_s == "release-group"
      #   "https://musicbrainz.org/ws/2/#{kind}/#{code}?inc=artists+url-rels&fmt=json"
      # elsif kind.to_s == "artist"
      #   "https://musicbrainz.org/ws/2/#{kind}/#{code}?inc=artist-rels+url-rels&fmt=json"
      # elsif kind == "recording"
      #   "https://musicbrainz.org/ws/2/#{kind}/#{code}?inc=artist-credits+url-rels&fmt=json"
      # else
      #   raise "Bad evil! #{kind} #{code}"
      # end
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
