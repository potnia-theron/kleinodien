module LayeredImport
  class MusicbrainzFetchLayer
    def initialize(order)
      @order = order
    end

    attr_reader :order

    def get(uri_string)
      max_tries.times do
        response = fetcher.get(uri_string)
        return response.body if response
      end

      raise "Failed to get #{uri_string}"
    end

    def connection
      @connection ||= Faraday.new do |faraday|
        faraday.response :logger, Rails.logger, {log_level: :debug}
        faraday.response :json, parser_options: {decoder: [LayeredImport::Json, :parse]}
      end
    end

    def fetcher
      @fetcher ||= LayeredImport::FaradayFetcher.new(order, clock_control, connection)
    end

    def clock_control
      @clock_control ||= LayeredImport::ClockControl.new(response_validator, timeout_calculator)
    end

    def response_validator
      proc { |response| response.success? }
    end

    def timeout_calculator
      # proc { |errors| minimal_timeout * (errors + 1) }
      # TODO: actual calculate the timeout
      proc { |_| 0 }
    end

    def max_tries
      # TODO: get max_tries from ENV
      3
    end
  end
end
