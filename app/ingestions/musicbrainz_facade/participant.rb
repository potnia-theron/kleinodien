module MusicbrainzFacade
  class Participant
    include Concerns::Scrapeable

    def initialize(factory, options)
      @factory = factory
      @options = options
    end

    attr_reader :factory, :options
    delegate :api, to: :factory

    def data
      @data ||= api.get(:artist, options[:musicbrainz_code])
    end

    def scraper_builder
      @@scraper_builder ||= Import::ScraperArchitect.build do
        define :name
        define :sort_name
        define :disambiguation
        define :begin_date, always: nil
        define :begin_date_accuracy, always: nil
        define :end_date, always: nil
        define :end_date_accuracy, always: nil
        define :discogs_code, callback: ->(facade) { facade.relations.dig(:discogs, :artist) }
        define :imdb_code, callback: ->(facade) { facade.relations.dig(:imdb, :name) }
        define :wikidata_code, callback: ->(facade) { facade.relations.dig(:wikidata, :wiki) }
        define :tmdb_code, always: nil
        define :musicbrainz_code, callback: ->(facade) { facade.musicbrainz_code }
      end
    end

    def all_codes = {}

    def cheap_codes = {musicbrainz_code: musicbrainz_code}

    def links
      @links ||= factory.create(:links, data[:relations])
    end

    def musicbrainz_code = options[:musicbrainz_code]

    def relations
      @relations ||= MusicbrainzFacade::RelationsCode.new(data[:relations]).extract
    end

    private

    def life_span_at(position)
      data
        .dig(:life_span, position)
        &.then { IncompleteDate.from_string(it) }
    end
  end
end
