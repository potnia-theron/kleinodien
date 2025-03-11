module Import
  class MusicbrainzParticipantFacade
    include Concerns::Scrapeable

    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options
    end

    attr_reader :facade_layer, :options

    delegate_missing_to :facade_layer

    def data
      @data ||= request_layer.get(:artist, options[:musicbrainz_code])
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
        define :musicbrainz_code, callback: ->(facade) { facade.data[:id] }
      end
    end

    def all_codes = {}

    def cheap_codes = {musicbrainz_code: scrape(:musicbrainz_code)}

    def relations
      @relations ||= Import::MusicbrainzRelationsCode.new(data[:relations]).extract
    end

    private

    def life_span_at(position)
      data.dig(:life_span, position)
        &.then { |date_string| IncompleteDate.from_string(date_string) }
    end
  end
end
