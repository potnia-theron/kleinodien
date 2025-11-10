module IngestionReflections
  class AlbumEdition < Base
    def record_class = ::AlbumEdition

    delegate_missing_to :record_class

    def create_finder = IngestionFinder::AlbumEdition.new

    def delegated_base_reflections = factory.create(:edition)
  end
end
