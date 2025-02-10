module LayeredImport
  class MusicbrainzArtistCreditParticipantFacade
    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options

      # debugger
    end

    attr_reader :facade_layer, :options
    delegate_missing_to :facade_layer

    def scraper_builder
      @@scraper_builder ||= LayeredImport::ScraperArchitect.build do
        define :join_phrase, :joinphrase
        define :participant, callback: ->(facade) { {musicbrainz_code: facade.musicbrainz_code} }
        define :position, callback: ->(facade) { facade.position }
      end
    end

    def scraper
      @scraper ||= scraper_builder.build(self)
    end

    delegate :get, to: :scraper
    delegate :get_many, to: :scraper

    def data
      options
    end

    def participant
      {musicbrainz_code: musicbrainz_code}
    end

    def join_phrase
      options[:joinphrase]
    end

    def musicbrainz_code
      options[:artist][:id]
    end

    def position
      options[:position]
    end
  end
end
