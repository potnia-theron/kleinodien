module LayeredImport
  # TODO: use an interrupter
  class MusicbrainzFetchLayer
    def initialize(order)
      @order = order
    end

    attr_reader :order

    def get(uri_string)
      result = attempts(uri_string)
      result.body
    end

    def connection
      @connection ||= Faraday.new do |faraday|
        faraday.response :logger, Rails.logger, {log_level: :debug}
        faraday.response :json, parser_options: {decoder: [LayeredImport::Json, :parse]}
      end
    end

    def attempts(uri_string)
      max_tries.times do
        connection.get(uri_string).then { |response| return response if response.success? }
      end

      raise "failed to get #{uri_string}"
    end

    def max_tries
      # get max_tries from ENV
      3
    end
  end
end
