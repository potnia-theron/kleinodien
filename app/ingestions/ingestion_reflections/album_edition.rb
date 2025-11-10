module IngestionReflections
  class AlbumEdition < Base
    def record_class = ::AlbumEdition

    def create_finder = IngestionFinder::AlbumEdition.new
  end
end
