module IngestionFinder
  class AlbumEdition
    include Callable
    include Concerns::CodeFindable

    def initialize(order, facade)
      @order = order
      @facade = facade
    end

    def call
      find_by_cheap_codes || find_by_codes
    end

    private

    attr_reader :order, :facade

    def model_class = ::AlbumEdition
  end
end
