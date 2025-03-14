module Import
  class MusicbrainzArtistCreditFacade
    include Concerns::Scrapeable

    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options
    end

    attr_reader :facade_layer, :options
    delegate_missing_to :facade_layer

    alias_method :data, :options

    def scraper_builder
      @@scraper_builder ||= Import::ScraperArchitect.build do
        define :name, callback: ->(facade) { facade.name }
        define :participants, callback: ->(facade) { facade.participants }
      end
    end

    def name
      data
        .map { |ac| [ac[:name], ac[:joinphrase]] }
        .flatten
        .tap { |tokens| raise "last participant must not contain anything" if tokens.last.present? }
        .tap { |tokens| tokens.pop }
        .join("")
    end

    def participants
      data.map.each_with_index { |ac_participant, idx| ac_participant.merge({position: idx}) }
    end
  end
end
