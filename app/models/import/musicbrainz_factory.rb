module Import
  class MusicbrainzFactory
    def initialize(import_order, buffer: nil)
      @buffer = buffer || Buffer.new
      @import_order = import_order
    end

    attr_reader :buffer, :import_order

    def build_attempt
      Import::FaradayAttempt.new(self)
    end

    def build_fetcher(uri_string)
      Import::Fetcher.new(factory: self, uri: uri_string)
    end

    def build_intermediate(model_class, code)
      adapter = build_adapter(model_class, code)
      Import::Intermediate.new(adapter: adapter, model_class: model_class)
    end

    def build_uri_string(kind, code)
      "https://musicbrainz.org/ws/2/#{kind}/#{code}?fmt=json"
    end

    def connection
      @connection ||= Faraday.new
    end

    def from
      @from ||= Import::From.new(import_order)
    end

    def interrupter
      @interrupt ||= Import::MusicbrainzInterrupter.new
    end

    def max_tries
      config.fetch(:max_tries, 3)
    end

    def config
      @config ||= Rails.configuration.import[:musicbrainz]
    end

    private

    def build_adapter(model_class, code)
      klass = "Import::Musicbrainz#{model_class.name}Adapter".constantize
      klass.new(self, code: code)
    end
  end
end
