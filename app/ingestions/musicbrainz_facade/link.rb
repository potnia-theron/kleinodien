module MusicbrainzFacade
  class Link
    include Concerns::Scrapeable

    def initialize(factory, options)
      @factory = factory
      @options = options
    end

    attr_reader :factory, :options
    delegate :api, to: :factory

    # def data = options
    def data
      options
    end

    def scraper_builder
      @@scraper_builder ||= FacadeScraper.build do
        define :link_kind, callback: ->(facade) { facade.link_kind }
        # define :name
        # define :sort_name
        # define :disambiguation
        # define :begin_date, always: nil
        # define :begin_date_accuracy, always: nil
        # define :end_date, always: nil
        # define :end_date_accuracy, always: nil
        # define :discogs_code, callback: ->(facade) { facade.relations.dig(:discogs, :artist) }
        # define :imdb_code, callback: ->(facade) { facade.relations.dig(:imdb, :name) }
        # define :wikidata_code, callback: ->(facade) { facade.relations.dig(:wikidata, :wiki) }
        # define :tmdb_code, always: nil
        # define :musicbrainz_code, callback: ->(facade) { facade.musicbrainz_code }
      end
    end

    def link_kind
      factory.create(:link_kind, options)
    end
  end
end
