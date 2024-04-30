module Import
  class MusicbrainzAlbumArchetypeFacade
    def initialize(session, options)
      @session = session
      @options = options
    end

    attr_reader :options, :session

    def model_class = AlbumArchetype

    def data
      options[:data]
    end

    delegate :title, to: :data

    def discogs_code
      all_codes[:discogs_code]
    end

    def musicbrainz_code
      data.id
    end

    def wikidata_code
      all_codes[:wikidata_code]
    end

    def artist_credit_facade
      session.build_facade(ArtistCredit, data: data.artist_credit)
    end

    def all_codes
      relations = Import::MusicbrainzRelationsCode.extract(data.relations)
      {
        discogs_code: relations.dig("discogs", "artist"),
        imdb_code: relations.dig("imdb", "name")
      }.compact
    end
  end
end
