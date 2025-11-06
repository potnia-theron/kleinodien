module MusicbrainzFacade
  class ArtistCreditParticipant
    include Concerns::Scrapeable

    def initialize(factory, options)
      @factory = factory
      @options = options
    end

    attr_reader :factory, :options
    delegate_missing_to :factory

    def scraper_builder
      @@scraper_builder ||= FacadeScraper.build do
        define :join_phrase, :joinphrase
        define :participant, callback: ->(facade) { facade.participant }
        define :position, callback: ->(facade) { facade.position }
      end
    end

    def data
      options
    end

    def musicbrainz_code
      options[:artist][:id]
    end

    def participant = factory.create(:participant, {musicbrainz_code: musicbrainz_code})

    def position
      options[:position]
    end
  end
end
