module Import
  class MusicbrainzParticipantFacade
    def initialize(session, options)
      @session = session
      @options = options
    end

    attr_reader :options, :session

    def model_class = Participant

    def data
      @data ||= options[:data] || session.get(:artist, options[:code])
    end

    def code
      options[:code] || data.id
    end

    delegate_missing_to :properties

    def cheap_codes
      return unless code

      {musicbrainz_code: code}
    end

    delegate :name, to: :data
    delegate :sort_name, to: :data
    delegate :disambiguation, to: :data

    def begins_at
      date_string = data.life_span.begin
      return unless date_string

      IncompleteDate.from_string(date_string)
    end

    def ends_at
      date_string = data.life_span.end
      return unless date_string

      IncompleteDate.from_string(date_string)
    end

    # OPTIMIZE: Implement a more general method to get the codes
    def discogs_code
      all_codes[:discogs_code]
    end

    def imdb_code
      all_codes[:imdb_code]
    end

    alias_method :musicbrainz_code, :code

    # Musicbrainz does not offer tmdb-codes, at least for artists
    # https://musicbrainz.org/relationships/artist-url
    def tmdb_code = nil

    # Wikidata URIs look like this (AC/DC):
    # https://www.wikidata.org/wiki/Q27593
    # there is no "type" that can be extracted from the URIs path.
    def wikidata_code = nil

    def all_codes
      relations = Import::MusicbrainzRelationsCode.extract(data.relations)
      {
        discogs_code: relations.dig("discogs", "artist"),
        imdb_code: relations.dig("imdb", "name")
      }.compact
    end
  end
end
