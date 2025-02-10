module LayeredImport
  class MusicbrainzAlbumArchetypeFacade
    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options
    end

    attr_reader :facade_layer, :options

    delegate_missing_to :facade_layer

    def data
      @data ||= request_layer.get(:release_group, options[:musicbrainz_code])
    end

    def scraper_builder
      @@scraper_builder ||= LayeredImport::ScraperArchitect.build do
        define :title
        define :artist_credit
        define :archetypeable_type, always: "AlbumArchetype"
        define :discogs_code, always: nil
        define :wikidata_code, always: nil
        define :musicbrainz_code, callback: ->(facade) { facade.options[:code] }
      end
    end

    def scraper
      @scraper ||= scraper_builder.build(self)
    end

    delegate :get, to: :scraper
    delegate :get_many, to: :scraper

    def archetypeable_type = "AlbumArchetype"

    def artist_credit
      data[:artist_credit]
    end

    # def title
    #   data[:title]
    # end

    def cheap_codes = {}

    def all_codes = {}

    def discogs_code = nil

    def musicbrainz_code = options[:code]

    def wikidata_code = nil
  end
end
