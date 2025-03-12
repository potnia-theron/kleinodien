module Import
  class SongArchetypeFinder
    include Callable
    include Concerns::CodeFindable

    def initialize(order, facade)
      @order = order
      @facade = facade
    end

    attr_reader :facade, :order

    def call
      find_by_cheap_codes || find_by_codes
    end

    def model_class = SongArchetype
  end
end
