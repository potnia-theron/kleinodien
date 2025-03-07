module Import
  class MusicbrainzEditionPositionFacade
    include Concerns::Scrapeable

    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options
    end

    attr_reader :facade_layer, :options
    delegate_missing_to :facade_layer

    def data
      options
    end

    def scraper_builder
      @@scraper_builder ||= Import::ScraperArchitect.build do
        define :alphanumeric, :number
        define :no, :position
        define :edition, callback: ->(facade) { :debugger }
      end
    end
  end
end
