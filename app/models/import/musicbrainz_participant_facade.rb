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

    def get
      session.get(:artist, options[:code])
    end

    def code
      options[:code] || data.id
    end

    def properties
      @properties ||= session.build_properties(model_class)
    end

    delegate_missing_to :properties

    def intrinsic_codes
      return unless code

      {musicbrainz_code: code}
    end

    delegate :name, to: :data
    delegate :sort_name, to: :data

    def artist_credit_participants
      session.build_facade_list(data: data, model: Participant)
    end

    def disambiguation = nil

    def begin_date = nil

    def begin_date_accuracy = nil

    def end_date = nil

    def end_date_accuracy = nil

    def discogs_code
      all_codes[:discogs_code]
    end

    def imdb_code
      all_codes[:imdb_code]
    end

    alias_method :musicbrainz_code, :code

    def tmdb_code = nil

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
