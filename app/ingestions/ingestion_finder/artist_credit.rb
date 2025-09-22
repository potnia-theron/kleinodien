module IngestionFinder
  class ArtistCredit
    include Callable
    include Concerns::CodeFindable

    attr_reader :facade, :order

    def call(facade)
      name = facade.name

      ::ArtistCredit.find_by(name: name)
    end
  end
end
