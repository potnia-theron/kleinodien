module IngestionFinder
  class AlbumEdition
    include Callable
    include Concerns::CodeFindable

    def call(facade)
      find_by_cheap_codes(facade) || find_by_codes(facade)
    end

    private

    attr_reader :order, :facade

    def model_class = ::AlbumEdition
  end
end
