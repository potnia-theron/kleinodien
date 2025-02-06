module LayeredImport
  class Scraper
    def initialize(callbacks, facade)
      @callbacks = callbacks
      @facade = facade
    end

    attr_reader :callbacks, :facade

    def get(attr)
      callback = callbacks[attr]
      raise ArgumentError, "no callback for \"#{attr}\"" unless callback

      callback.call(facade)
    end

    def get_many(*attrs)
      attrs.flatten.index_with { |attr| get(attr) }
    end
  end
end
