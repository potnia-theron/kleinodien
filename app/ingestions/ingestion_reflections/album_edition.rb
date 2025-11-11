module IngestionReflections
  class AlbumEdition < Default
    def record_class = ::AlbumEdition

    def create_finder = IngestionFinder::AlbumEdition.new
  end
end
