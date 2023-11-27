module Import
  class MusicbrainzFactory
    def initialize(buffer: nil, import_order: nil)
      # TODO: @import_order musten't be nil
      @buffer = buffer || Buffer.new
      @import_order = import_order
    end

    attr_reader :buffer

    def build_uri(kind, code)
      "https://musicbrainz.org/ws/2/#{kind}/#{code}?fmt=json"
    end
  end
end
