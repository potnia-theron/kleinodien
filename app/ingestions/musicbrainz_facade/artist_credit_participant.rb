module MusicbrainzFacade
  class ArtistCreditParticipant
    include Concerns::Scrapeable

    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options
    end

    attr_reader :facade_layer, :options
    delegate_missing_to :facade_layer

    def scraper_builder
      @@scraper_builder ||= Import::ScraperArchitect.build do
        define :join_phrase, :joinphrase
        define :participant, callback: ->(facade) { {musicbrainz_code: facade.musicbrainz_code} }
        define :position, callback: ->(facade) { facade.position }
      end
    end

    def data
      options
    end

    def musicbrainz_code
      options[:artist][:id]
    end

    def position
      options[:position]
    end
  end
end
