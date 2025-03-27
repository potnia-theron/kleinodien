module Import
  class LinkKindFinder
    include Callable

    def initialize(order, facade)
      @order = order
      @facade = facade
    end

    def call
      LinkKind.find_by(name: facade.scrape(:name))
    end

    private

    attr_reader :facade, :order
  end
end
