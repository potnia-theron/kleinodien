module MusicbrainzFacade
  class AlbumEdition
    include Concerns::Scrapeable

    def initialize(factory, options)
      @factory = factory
      @options = options
    end

    attr_reader :factory, :options
    delegate_missing_to :factory

    def data
      @data ||= api.get(:release, options[:musicbrainz_code])
    end

    def scraper_builder
      @@scraper_builder ||= Import::ScraperArchitect.build do
        # define :archetype, :release_group
        define :archetype, callback: ->(facade) { facade.archetype }
        define :editionable_type, always: "AlbumEdition"
        # define :sections, callback: ->(facade) { facade.data[:media] }
        define :sections, callback: ->(facade) { facade.sections }
        define :discogs_code, callback: ->(facade) { facade.relations.dig(:discogs, :release) }
        define :musicbrainz_code, callback: ->(facade) { facade.options[:code] }
        define :wikidata_code, callback: ->(facade) { facade.relations.dig(:wikidata, :wiki) }
      end
    end

    def all_codes = {}

    def cheap_codes = {}

    def archetype
      factory.create(:album_archetype, data[:release_group])
    end

    def relations
      @relations ||= MusicbrainzFacade::RelationsCode.new(data[:relations]).extract
    end

    def sections = @sections ||= data[:media].map { factory.create(:edition_section, it) }
  end
end
