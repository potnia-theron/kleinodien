module Import
  class UrlFinder
    include Callable

    def initialize(order, facade)
      @order = order
      @facade = facade
    end

    def call
      Url.find_by(address: facade.scrape(:address))
    end

    private

    attr_reader :facade, :order

    def model_class = Url
  end
end
