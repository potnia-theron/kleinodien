module LayeredImport
  class Scraper
    def initialize(callbacks)
      @callbacks = callbacks
    end

    attr_reader :callbacks

    def get(attr, facade)
      callback = callbacks[attr]
      raise ArgumentError, "no callback for \"#{attr}\"" unless callback

      callback.call(facade)
    end

    def get_many(*attrs, facade)
      attrs.flatten.index_with { |attr| get(attr, facade) }
    end
  end
end
