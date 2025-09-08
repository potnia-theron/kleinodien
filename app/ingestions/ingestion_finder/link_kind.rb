module IngestionFinder
  class LinkKind
    include Callable

    def model_class = ::LinkKind

    def initialize(order, facade)
      @order = order
      @facade = facade
    end

    def call
      model_class.find_by(name: facade.scrape(:name))
    end

    private

    attr_reader :facade, :order
  end
end
