module Import
  class MusicbrainzParticipantFacade
    def initialize(session, options)
      @session = session
      @options = options

      # fill the buffer by calling #data:
      data
    end

    attr_reader :options, :session

    def model_class = Participant

    def data
      # @data ||= options[:data] || session.get(:artist, options[:code])
      @data ||= session.get(:artist, options[:code])
    end

    def code
      options[:code] || data[:id]
    end

    delegate_missing_to :properties

    def buffered?
      session.buffer.buffered? :artist, options[:code]
    end

    def cheap_codes
      return unless code

      {musicbrainz_code: code}
    end

    def name
      data[:name]
    end

    def sort_name
      data[:sort_name]
    end

    def disambiguation
      data[:disambiguation]
    end

    def begins_at
      date_string = data.dig(:life_span, :begin)
      return unless date_string

      IncompleteDate.from_string(date_string)
    end

    def ends_at
      # date_string = data.life_span.end
      date_string = data.dig(:life_span, :end)
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
      relations = Import::MusicbrainzRelationsCode.extract(data[:relations])
      {
        discogs_code: relations.dig(:discogs, :artist),
        imdb_code: relations.dig(:imdb, :name)
      }.compact
    end
  end
end
