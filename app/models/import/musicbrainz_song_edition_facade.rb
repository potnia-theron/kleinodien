module Import
  class MusicbrainzSongEditionFacade
    include Concerns::Scrapeable

    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options
    end

    attr_reader :facade_layer, :options

    def data
      options
    end

    def scraper_builder
      @@scraper_builder ||= Import::ScraperArchitect.build do
        define :archetype, :recording
        define :editionable_type, always: "SongEdition"
        define :sections, always: []
        define :discogs_code, always: nil
        define :musicbrainz_code, callback: ->(facade) { facade.options[:code] }
        define :wikidata_code, always: nil
      end
    end
  end
end
