module IngestionFinder
  class SongArchetype
    include Callable
    include Concerns::CodeFindable

    # def initialize
    #   @order = order
    #   @facade = facade
    # end

    attr_reader :facade, :order

    def call(facade)
      find_by_cheap_codes(facade) || find_by_codes(facade)
    end

    def model_class = ::SongArchetype
  end
end
