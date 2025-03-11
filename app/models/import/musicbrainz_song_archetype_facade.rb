module Import
  class MusicbrainzSongArchetypeFacade
    include Concerns::Scrapeable

    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options
    end

    attr_reader :facade_layer, :options

    delegate_missing_to :facade_layer

    def data
      @data ||= request_layer.get(:recording, options[:id])
    end

    def scraper_builder
      @@scraper_builder ||= Import::ScraperArchitect.build do
        define :title
        define :artist_credit
        define :archetypeable_type, always: "SongArchetype"
        define :discogs_code, always: nil
        define :wikidata_code, always: nil
        define :musicbrainz_code, callback: ->(facade) { facade.options[:code] }
      end
    end

    def all_codes = {}

    def cheap_codes = {}

    def musicbrainz_code = options[:musicbrainz_code] || options[:id]
  end
end
