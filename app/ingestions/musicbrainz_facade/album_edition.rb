module MusicbrainzFacade
  class AlbumEdition
    include Concerns::Scrapeable

    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options
    end

    attr_reader :facade_layer, :options
    delegate_missing_to :facade_layer

    def data
      @data ||= request_layer.get(:release, options[:musicbrainz_code])
    end

    def scraper_builder
      @@scraper_builder ||= Import::ScraperArchitect.build do
        define :archetype, :release_group
        define :editionable_type, always: "AlbumEdition"
        define :sections, callback: ->(facade) { facade.data[:media] }
        define :discogs_code, callback: ->(facade) { facade.relations.dig(:discogs, :release) }
        define :musicbrainz_code, callback: ->(facade) { facade.options[:code] }
        define :wikidata_code, callback: ->(facade) { facade.relations.dig(:wikidata, :wiki) }
      end
    end

    def all_codes = {}

    def cheap_codes = {}

    def relations
      @relations ||= MusicbrainzFacade::RelationsCode.new(data[:relations]).extract
    end
  end
end
