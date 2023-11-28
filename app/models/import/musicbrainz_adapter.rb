module Import
  class MusicbrainzAdapter
    def initialize(from)
      @from = from
    end

    attr_reader :from

    def participants
      buffered["artist"]&.map do |musicbrainz_code, artist|
        {
          name: artist["name"],
          sort_name: artist["sort_name"],
          musicbrainz_code: musicbrainz_code
        }
      end
    end

    def buffered
      @buffered ||= from.musicbrainz.dump_buffer
    end
  end
end
