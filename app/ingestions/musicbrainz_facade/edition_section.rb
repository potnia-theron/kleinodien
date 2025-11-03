module MusicbrainzFacade
  class EditionSection
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

    def scraper_builder
      @@scraper_builder ||= Import::ScraperArchitect.build do
        define :alphanumeric, :position
        define :level, always: 1
        define :no, :position
        define :positions, callback: ->(facade) { facade.positions }
      end
    end

    def positions = data[:tracks].map { factory.create(:edition_position, it) }
  end
end
