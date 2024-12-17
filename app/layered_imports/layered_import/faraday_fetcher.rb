module LayeredImport
  class FaradayFetcher
    def initialize(fetch_layer, uri)
      @fetch_layer = fetch_layer
      @uri = uri
    end

    attr_reader :fetch_layer, :uri
    delegate_missing_to :fetch_layer

    def get
      max_tries.times do
        response = clock_control.schedule { attempt }
        return response if response
      end

      raise "failed to get #{uri}"
    end

    private

    def attempt
      response = connection.get(uri)
      response if response.success?
    end
  end
end
