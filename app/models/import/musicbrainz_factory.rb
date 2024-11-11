module Import
  class MusicbrainzFactory < Factory
    def build_attempt
      Import::FaradayAttempt.new(self)
    end

    def build_facade(model, **)
      name = model.name
      facade_class = "Import::Musicbrainz#{name}Facade".constantize
      facade_class.new(session, **)
    end

    def build_uri_string(kind, code)
      "https://musicbrainz.org/ws/2/#{kind}/#{code}?fmt=json"
    end

    def connection
      @connection ||= Faraday.new do |faraday|
        faraday.response :logger, Rails.logger, {log_level: :debug}
      end
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

    def transform_response(response)
      Import::Json.parse(response.body)
    end
  end
end
