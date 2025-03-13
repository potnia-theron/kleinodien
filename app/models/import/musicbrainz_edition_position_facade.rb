module Import
  class MusicbrainzEditionPositionFacade
    include Concerns::Scrapeable

    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options
    end

    attr_reader :facade_layer, :options
    delegate_missing_to :facade_layer

    alias_method :data, :options

    def scraper_builder
      @@scraper_builder ||= Import::ScraperArchitect.build do
        define :alphanumeric, :number
        define :no, :position
      end
    end

    def delegated_type_for(association)
      # TODO: really check for the required type
      "SongEdition"
    end
  end
end
