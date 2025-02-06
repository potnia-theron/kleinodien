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

    def scraper
      @@scraper ||= LayeredImport::ScraperBuilder.build do
        dig(:title)
        always(:archetypeable_type, "AlbumArchetype")
        always(:discogs_code)
        always(:wikidata_code)
        callback(:musicbrainz_code, ->(facade) { facade.options[:code] })
      end
    end

    def get_many(attr_names)
      scraper.get_many(attr_names, self)
    end

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
