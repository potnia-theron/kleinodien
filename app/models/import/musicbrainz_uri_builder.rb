module Import
  class MusicbrainzUriBuilder
    def initialize(prefix = "https://musicbrainz.org")
      @prefix = prefix
    end

    def call(kind, code)
      case kind.to_s
      when "release"
        "https://musicbrainz.org/ws/2/#{kind}/#{code}?inc=artists+artist-rels+labels+media+recordings+release-groups+url-rels&fmt=json"
      when "release-group"
        "https://musicbrainz.org/ws/2/#{kind}/#{code}?inc=artists+url-rels&fmt=json"
      when "artist"
        "https://musicbrainz.org/ws/2/#{kind}/#{code}?inc=artist-rels+url-rels&fmt=json"
      when "recording"
        "https://musicbrainz.org/ws/2/#{kind}/#{code}?inc=artist-credits+url-rels&fmt=json"
      else
        raise "Bad evil! #{kind} #{code}"
      end
    end

    private

    attr_reader :prefix
  end
end
