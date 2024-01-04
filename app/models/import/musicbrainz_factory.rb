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

    def purify(response)
      JSON.parse(response.body)
    end

    def config
      @config ||= Rails.configuration.import[:musicbrainz]
    end

    private

    # TODO: Work with a real adapter
    # def build_adapter(model_class, code)
    #   adapter = Object.new
    #   adapter.define_singleton_method(:inherent_codes_hash) { {musicbrainz_code: "66c662b6-6e2f-4930-8610-912e24c63ed1"} }
    #   adapter.define_singleton_method(:full_codes_hash) { {musicbrainz_code: "66c662b6-6e2f-4930-8610-912e24c63ed1", discogs_code: "123"} }
    #   adapter.define_singleton_method(:arguments) { {name: "AC/DC"} }

    #   adapter
    # end
    def build_adapter(model_class, code)
      klass = "Import::Musicbrainz#{model_class.name}Adapter".constantize
      klass.new(self, code: code)
    end
  end
end
