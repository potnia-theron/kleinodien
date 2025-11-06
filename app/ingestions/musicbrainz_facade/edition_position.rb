module MusicbrainzFacade
  class EditionPosition
    include Concerns::Scrapeable

    def initialize(factory, options)
      @factory = factory
      @options = options
    end

    attr_reader :factory, :options
    delegate_missing_to :factory

    alias_method :data, :options

    def scraper_builder
      @@scraper_builder ||= FacadeScraper.build do
        define :alphanumeric, :number
        define :no, :position
        define :edition, callback: ->(facade) { facade.edition }
      end
    end

    def edition = create(edition_class_name, edition_data)

    def delegated_type_for(_)
      return "SongEdition" unless data[:recording][:video]

      raise "can't determinate delegated_type for data"
    end

    private

    def edition_data = data.merge(ingestion_reflections: ingestion_reflections)

    def ingestion_reflections = reflections_factory.create(edition_class_name)

    def edition_class_name
      return "SongEdition" unless data[:recording][:video]

      raise "can't determinate delegated_type for data"
    end
  end
end
