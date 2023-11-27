module Import
  class MusicbrainzFactory
    def initialize(import_order, buffer: nil)
      @buffer = buffer || Buffer.new
      @import_order = import_order
    end

    attr_reader :buffer

    def attempt
      Import::FaradayAttempt.new(self)
    end

    def build_fetcher(uri_string)
      Import::Fetcher.new(factory: self, uri: uri_string)
    end

    def build_uri(kind, code)
      "https://musicbrainz.org/ws/2/#{kind}/#{code}?fmt=json"
    end

    def connection
      obj = Object.new
      obj.define_singleton_method(:get) { |_| :foo }
      obj
    end

    def interrupter
      @interrupt ||= Import::MusicbrainzInterrupter.new
    end

    # TODO: read #max_tries from config
    def max_tries = 1

    def purify(response)
      response
    end
  end
end
