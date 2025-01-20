module LayeredImport
  class FaradayFetcher
    def initialize(order, clock_control, connection)
      @order = order
      @clock_control = clock_control
      @connection = connection
    end

    def get(uri)
      clock_control.schedule { attempt(uri) }
    end

    private

    attr_reader :clock_control, :connection, :order

    def attempt(uri)
      response = connection.get(uri)
      response if response.success?
    end
  end
end
