module LayeredImport
  class MusicbrainzArtistCreditParticipantFacade
    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options

      # debugger
    end

    attr_reader :facade_layer, :options
    delegate_missing_to :facade_layer

    def scraper
      @@scraper ||= LayeredImport::ScraperBuilder.build do |builder|
        builder.dig(:join_phrase, :joinphrase)
        builder.callback(:position, ->(facade) { facade.position })
      end
    end

    def get_many(attr_names)
      scraper.get_many(attr_names, self)
    end

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
