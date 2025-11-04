module MusicbrainzApi
  class UriBuilder
    INC_FOR = {
      "artist" => "?inc=artist-rels+url-rels",
      "recording" => "?inc=artist-credits+url-rels",
      "release" => "?inc=artists+artist-rels+labels+media+recordings+release-groups+url-rels",
      "release-group" => "?inc=artists+url-rels"
    }.freeze

    def initialize(prefix = "https://musicbrainz.org")
      @prefix = prefix
    end

    def build(kind, code)
      kind
        .to_s
        .dasherize
        .then { "#{prefix}/ws/2/#{it}/#{code}#{inc_for(it)}&fmt=json" }
    end

    private

    attr_reader :prefix

    def inc_for(kind)
      INC_FOR[kind]
        .tap { raise ArgumentError, "don't know how to build an uri for #{kind}" unless it }
    end
  end
end
