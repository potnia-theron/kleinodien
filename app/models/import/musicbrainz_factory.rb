module Import
  class MusicbrainzFactory
    def initialize(import_order, buffer: nil)
      @buffer = buffer || Buffer.new
      @import_order = import_order
    end

    attr_reader :buffer

    def build_attempt
      Import::FaradayAttempt.new(self)
    end

    def build_fetcher(uri_string)
      Import::Fetcher.new(factory: self, uri: uri_string)
    end

    def build_uri_string(kind, code)
      "https://musicbrainz.org/ws/2/#{kind}/#{code}?fmt=json"
    end

    def connection
      @connection ||= Faraday.new
    end

    def interrupter
      @interrupt ||= Import::MusicbrainzInterrupter.new
    end

    # TODO: read #max_tries from config
    def max_tries = 1

    def purify(response)
      JSON.parse(response.body)
    end
  end
end
