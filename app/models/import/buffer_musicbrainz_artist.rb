module Import
  class BufferMusicbrainzArtist
    def initialize(from)
      @from = from
    end

    attr_reader :from

    def perform(musicbrainz_code)
      return if musicbrainz_api.buffered?(:artist, musicbrainz_code)
      return if find_participant_by_musicbrainz_code(musicbrainz_code)

      musicbrainz_api.get(:artist, musicbrainz_code)
    end

    def find_participant_by_musicbrainz_code(musicbrainz_code)
      Participant.find_by(musicbrainz_code: musicbrainz_code)
    end

    def musicbrainz_api
      @musicbrainz_api ||= from.musicbrainz
    end
  end
end
