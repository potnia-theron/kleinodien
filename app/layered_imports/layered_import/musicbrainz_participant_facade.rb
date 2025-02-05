module LayeredImport
  class MusicbrainzParticipantFacade
    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options
    end

    attr_reader :facade_layer, :options

    delegate_missing_to :facade_layer

    def data
      @data ||= request_layer.get(:artist, options[:musicbrainz_code])
    end

    def scraper
      @@scraper ||= LayeredImport::ScraperBuilder.build do |builder|
        builder.dig(:name)
        builder.dig(:sort_name)
        builder.dig(:disambiguation)
        # TODO: stop returning nil for date related data
        builder.always(:begin_date)
        builder.always(:begin_date_accuracy)
        builder.always(:end_date)
        builder.always(:end_date_accuracy)
        builder.callback(:discogs_code, ->(facade) { facade.relations.dig(:discogs, :artist) })
        builder.callback(:imdb_code, ->(facade) { facade.relations.dig(:imdb, :name) })
        builder.callback(:wikidata_code, ->(facade) { facade.relations.dig(:wikidata, :wiki) })
        builder.always(:tmdb_code)
        builder.callback(:musicbrainz_code, ->(facade) { facade.data[:id] })
      end
    end

    def get_many(keys)
      scraper.get_many(keys, self)
    end

    def all_codes = {}

    def cheap_codes = {}

    def name = scraper.get(:name, data)

    def sort_name = scraper.get(:sort_name, data)

    def disambiguation = data[:disambiguation]

    def begin_date
      life_span_at(:begin)&.date
    end

    def begin_date_accuracy
      life_span_at(:begin)&.accuracy
    end

    def end_date
      life_span_at(:end)&.date
    end

    def end_date_accuracy
      life_span_at(:end)&.accuracy
    end

    def discogs_code = relations.dig(:discogs, :artist)

    def imdb_code = relations.dig(:imdb, :name)

    def musicbrainz_code = data[:id]

    def tmdb_code
      # TODO: implement #tmdb_code
    end

    def wikidata_code = relations.dig(:wikidata, :wiki)

    def relations
      @relations ||= LayeredImport::MusicbrainzRelationsCode.new(data[:relations]).extract
    end

    private

    def life_span_at(position)
      data.dig(:life_span, position)
        &.then { |date_string| IncompleteDate.from_string(date_string) }
    end
  end
end
