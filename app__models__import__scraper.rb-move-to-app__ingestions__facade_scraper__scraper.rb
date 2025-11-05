module Import
  class Scraper
    def initialize(callbacks, facade)
      @callbacks = callbacks
      @facade = facade
    end

    attr_reader :callbacks, :facade

    def scrape(attr)
      callback = callbacks[attr]
      raise ArgumentError, "don't know how to scrape :#{attr} from #{facade.class}" unless callback

      Rails.logger.debug { "scraping :#{attr} from #{facade.class}" }

      value = callback.call(facade)

      Rails.logger.warn("scraped value for :#{attr} is nil, hope that's ok") if value.nil?

      value
    end

    def scrape_many(*attrs)
      attrs.flatten.index_with { |attr| scrape(attr) }.with_indifferent_access
    end
  end
end
