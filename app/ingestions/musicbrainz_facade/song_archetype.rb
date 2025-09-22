module MusicbrainzFacade
  class SongArchetype
    include Concerns::Scrapeable

    def initialize(factory, options)
      @factory = factory
      @options = options
    end

    attr_reader :factory, :options

    delegate_missing_to :factory

    def data
      # @data ||= request_layer.get(:recording, options[:id])
      @data ||= api.get(:recording, options[:id])
    end

    def scraper_builder
      @@scraper_builder ||= Import::ScraperArchitect.build do
        define :title
        # define :artist_credit
        define :artist_credit, callback: ->(facade) { facade.artist_credit }
        define :archetypeable_type, always: "SongArchetype"
        define :discogs_code, always: nil
        define :wikidata_code, always: nil
        define :musicbrainz_code, callback: ->(facade) { facade.options[:code] }
      end
    end

    def all_codes = {}

    def cheap_codes = {}

    def artist_credit = create(:artist_credit, data[:artist_credit])

    def musicbrainz_code = options[:musicbrainz_code] || options[:id]
  end
end
