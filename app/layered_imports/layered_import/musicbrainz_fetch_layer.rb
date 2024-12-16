module LayeredImport
  # TODO: use an interrupter
  class MusicbrainzFetchLayer
    def initialize(order)
      @order = order
    end

    attr_reader :order

    def get(uri_string)
      result = connection.get(uri_string)
      # TODO: check the result
      # ...by using the nonexistent interrupter
      json = result.body
      Json.parse(json)
    end

    def connection
      @connection ||= Faraday.new do |faraday|
        faraday.response :logger, Rails.logger, {log_level: :debug}
      end
    end
  end
end
