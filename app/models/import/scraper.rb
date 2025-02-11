module Import
  class Scraper
    def initialize(callbacks, facade)
      @callbacks = callbacks
      @facade = facade
    end

    attr_reader :callbacks, :facade

    def scrape(attr)
      callback = callbacks[attr]
      raise ArgumentError, "no callback for \"#{attr}\"" unless callback

      callback.call(facade)
    end

    def scrape_many(*attrs)
      attrs.flatten.index_with { |attr| scrape(attr) }
    end
  end
end
