module Import
  class MusicbrainzLinkKindFacade
    include Concerns::Scrapeable

    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options
    end

    attr_reader :facade_layer, :options
    # alias_method :data, :options
    def data
      # debugger
      options
    end

    def scraper_builder
      @@scraper_builder ||= Import::ScraperArchitect.build do
        define :name
        define :description
        define :link_phrase
        define :reverse_link_phrase
        define :long_link_phrase
        define :musicbrainz_code, :id
      end
    end
  end
end
