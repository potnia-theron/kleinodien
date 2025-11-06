module MusicbrainzFacade
  class ArtistCredit
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
        define :name, callback: ->(facade) { facade.name }
        define :participants, callback: ->(facade) { facade.participants }
      end
    end

    def name
      data
        .map { [it[:name], it[:joinphrase]] }
        .flatten
        .tap { raise "last participant must not contain anything" if it.last.present? }
        .tap { it.pop }
        .join("")
    end

    def participants
      data
        .map
        .each_with_index { |acp_hash, idx| acp_hash.merge({position: idx}) }
        .map { factory.create(:artist_credit_participant, it) }
    end
  end
end
