module IngestionFinder
  class ArtistCredit
    include Callable
    include Concerns::CodeFindable

    def initialize(order, facade)
      @order = order
      @facade = facade
    end

    attr_reader :facade, :order

    def call
      name = facade.name

      ::ArtistCredit.find_by(name: name)
    end
  end
end
