module LayeredImport
  # TODO: use an interrupter
  class MusicbrainzFetchLayer
    def initialize(order)
      @order = order
    end

    attr_reader :order

    def get(uri_string)
      fetcher = create_fetcher(uri_string)
      response = fetcher.get
      response.body
    end

    def connection
      @connection ||= Faraday.new do |faraday|
        faraday.response :logger, Rails.logger, {log_level: :debug}
        faraday.response :json, parser_options: {decoder: [LayeredImport::Json, :parse]}
      end
    end

    def create_fetcher(uri_string)
      LayeredImport::FaradayFetcher.new(self, uri_string)
    end

    def clock_control
      @clock_control ||= LayeredImport::ClockControl.new(timeout_calculator)
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
