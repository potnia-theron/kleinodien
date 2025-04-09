module Import
  class MusicbrainzUriBuilder
    INC_FOR = {
      "artist" => "?inc=artist-rels+url-rels",
      "recording" => "?inc=artist-credits+url-rels",
      "release" => "?inc=artists+artist-rels+labels+media+recordings+release-groups+url-rels",
      "release-group" => "?inc=artists+url-rels"
    }.freeze

    def initialize(prefix = "https://musicbrainz.org")
      @prefix = prefix
    end

    def call(kind, code)
      inc = inc_for(kind)

      "#{prefix}/ws/2/#{kind}/#{code}#{inc}&fmt=json"
    end

    private

    attr_reader :prefix

    def inc_for(kind)
      INC_FOR[kind.to_s]
        .tap { raise ArgumentError, "don't know how to build an uri for #{kind}" unless it }
    end
  end
end
