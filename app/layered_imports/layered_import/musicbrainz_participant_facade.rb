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

    def all_codes = {}

    def cheap_codes = {}

    def name = data[:name]

    def sort_name = data[:sort_name]

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

    private

    def life_span_at(position)
      data.dig(:life_span, position)
        &.then { |date_string| IncompleteDate.from_string(date_string) }
    end

    def relations
      @relations ||= LayeredImport::MusicbrainzRelationsCode.new(data[:relations]).extract
    end
  end
end
