module Import
  class MusicbrainzFetchLayer
    def initialize(order)
      @order = order
    end

    def get(uri_string)
      Rails.logger.debug("attempt to get #{uri_string}")
      max_tries.times do |error_count|
        take_timeout(error_count)
        response = connection.get(uri_string)
        return response.body if response.success?
      end

      raise "Failed to get #{uri_string}"
    end

    private

    attr_reader :order

    def connection
      @connection ||= Faraday.new do |faraday|
        faraday.response :logger, Rails.logger, {log_level: :debug}
        faraday.response :json, parser_options: {decoder: [Import::Json, :parse]}
      end
    end

    def take_timeout(error_count)
      timeout.take(error_count)
    end

    def timeout
      @timeout ||= Timeout.new(timeout_calculator)
    end

    def timeout_calculator
      proc { |error_count| minimal_timeout * (error_count + 1) }
    end

    def max_tries
      # config[:max_tries] || 3
      config.fetch(:max_tries, 3)
    end

    def minimal_timeout
      # config[:minimal_timeout] || 1
      config.fetch(:minimal_timeout, 1)
    end

    def config
      @config ||= Rails.configuration&.import&.[](:musicbrainz) || {}
    end
  end
end
