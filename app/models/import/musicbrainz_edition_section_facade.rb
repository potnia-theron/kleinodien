module Import
  class MusicbrainzEditionSectionFacade
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
        define :alphanumeric, :position
        define :level, always: 1
        define :no, :position
        # define :positions, callback: ->(facade) { facade.positions }
        define :positions, :tracks
      end
    end
  end
end
