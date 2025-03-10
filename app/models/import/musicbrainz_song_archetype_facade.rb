module Import
  class MusicbrainzSongArchetypeFacade
    include Concerns::Scrapeable

    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options
    end

    attr_reader :facade_layer, :options

    delegate_missing_to :facade_layer

    def data
      options
    end

    def scraper_builder
      @@scraper_builder ||= Import::ScraperArchitect.build do
        define :title
        define :artist_credit, callback: ->(facade) { facade.artist_credit }
        define :archetypeable_type, always: "SongArchetype"
        define :discogs_code, always: nil
        define :wikidata_code, always: nil
        define :musicbrainz_code, callback: ->(facade) { facade.options[:code] }
      end
    end

    def all_codes = {}

    def cheap_codes = {}

    def artist_credit
      [{
        joinphrase: "",
        name: "AC/DC",
        artist: {
          disambiguation: "Australian hard rock band",
          type: "Group",
          id: "66c662b6-6e2f-4930-8610-912e24c63ed1",
          sort_name: "AC/DC",
          name: "AC/DC",
          type_id: "e431f5f6-b5d2-343d-8b36-72607fffb74b"
        }
      }]
    end

    def musicbrainz_code = options[:musicbrainz_code] || options[:id]
  end
end
