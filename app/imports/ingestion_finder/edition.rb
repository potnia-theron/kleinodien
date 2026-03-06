module IngestionFinder
  class Edition < IngestionFinder::NullFinder
    include Callable
    include Concerns::CodeFindable

    def call(facade)
      find_by_cheap_codes(facade) || find_by_codes(facade)
    end

    def model_class = ::Participant
  end
end
