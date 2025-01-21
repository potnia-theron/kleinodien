module LayeredImport
  class MusicbrainzFetchLayer
    def initialize(order)
      @order = order
    end

    attr_reader :order

    def get(uri_string)
      max_tries.times do |error_count|
        take_timeout(error_count)
        response = connection.get(uri_string)
        return response.body if response.success?
      end

      raise "Failed to get #{uri_string}"
    end

    def connection
      @connection ||= Faraday.new do |faraday|
        faraday.response :logger, Rails.logger, {log_level: :debug}
        faraday.response :json, parser_options: {decoder: [LayeredImport::Json, :parse]}
      end
    end

    def response_validator
      proc { |response| response.success? }
    end

    def take_timeout(_)
      timeout.take
    end

    def timeout
      @timeout = Timeout.new(timeout_calculator)
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
