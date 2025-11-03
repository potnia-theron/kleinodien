module MusicbrainzFacade
  class SongEdition
    include Concerns::Scrapeable

    def initialize(factory, options)
      @factory = factory
      @options = options
    end

    attr_reader :factory, :options
    delegate_missing_to :factory

    def data
      options
    end

    def cheap_codes = {}

    def all_codes = {}

    def scraper_builder
      @@scraper_builder ||= Import::ScraperArchitect.build do
        define :archetype, callback: ->(facade) { facade.archetype }
        define :editionable_type, always: "SongEdition"
        define :sections, always: []
        define :discogs_code, always: nil
        define :musicbrainz_code, callback: ->(facade) { facade.options[:code] }
        define :wikidata_code, always: nil
        define :ingestion_reflections, callback: ->(facade) { facade.ingestion_reflections }
      end
    end

    def archetype
      create(:song_archetype, data[:recording])
    end

    def ingestion_reflections = factory.reflections_factory.create("SongEdition")
  end
end
