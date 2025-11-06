module MusicbrainzApi
  class OpenApi
    def initialize(config)
      @config = config
    end

    def get(uri_string)
      max_tries.times do |error_count|
        take_timeout(error_count)
        response = connection.get(uri_string)
        return response.body if response.success?
      end

      raise "Failed to get #{uri_string}"
    end

    private

    attr_reader :config

    def connection
      @connection ||= Faraday.new do |faraday|
        faraday.response :logger, Rails.logger, {log_level: :debug}
        faraday.response :json, parser_options: {decoder: [Ingestion::Json, :parse]}
      end
    end

    def take_timeout(error_count) = timeout.take(error_count)

    def timeout
      @timeout ||= Timeout.new(timeout_calculator)
    end

    def timeout_calculator = proc { |error_count| minimal_timeout * (error_count + 1) }

    def max_tries = config.fetch(:max_tries, 3)

    def minimal_timeout = config.fetch(:minimal_timeout, 1)
  end
end
