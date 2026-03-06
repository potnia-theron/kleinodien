module MusicbrainzFacade
  class AlbumArchetype
    include Concerns::Scrapeable

    def initialize(factory, options)
      @factory = factory
      @options = options
    end

    attr_reader :factory, :options
    delegate :api, to: :factory

    def data = @data ||= api.get(:release_group, musicbrainz_code)

    def scraper_builder
      @@scraper_builder ||= FacadeScraper.build do
        define :title
        define :artist_credit, callback: ->(facade) { facade.artist_credit }
        define :archetypeable_type, always: "AlbumArchetype"
        define :discogs_code, always: nil
        define :wikidata_code, always: nil
        define :musicbrainz_code, callback: ->(facade) { facade.options[:code] }
      end
    end

    def artist_credit
      factory.create(:artist_credit, data[:artist_credit])
    end

    def all_codes = {}

    def cheap_codes = {}

    def musicbrainz_code
      options[:musicbrainz_code] || options[:id]
    end

    def desired_delegated_type = :album_archetype
  end
end
