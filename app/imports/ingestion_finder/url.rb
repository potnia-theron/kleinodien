module IngestionFinder
  class Url
    include Callable

    def initialize
      @order = order
      @facade = facade
    end

    def call
      model_class.find_by(address: facade.scrape(:address))
    end

    private

    attr_reader :facade, :order

    def model_class = ::Url
  end
end
