module LayeredImport
  class ScraperBuilder
    def initialize(callbacks)
      @callbacks = callbacks.with_indifferent_access.freeze
    end

    def build(facade)
      Scraper.new(callbacks, facade)
    end

    attr_reader :callbacks
  end
end
