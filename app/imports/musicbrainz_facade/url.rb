module MusicbrainzFacade
  class Url
    include Concerns::Scrapeable

    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options
    end

    def scraper_builder
      @@scraper_builder ||= FacadeScraper.build do
        define :address, :resource
      end
    end

    attr_reader :facade_layer, :options
    alias_method :data, :options
  end
end
