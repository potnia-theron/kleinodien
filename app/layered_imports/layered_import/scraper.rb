module LayeredImport
  class Scraper
    def initialize(callbacks)
      @callbacks = callbacks
    end

    attr_reader :callbacks

    def get(attr, data)
      callback = callbacks[attr]
      raise ArgumentError, "no callback for \"attr\"" unless callback

      callback.call(data)
    end
  end
end
