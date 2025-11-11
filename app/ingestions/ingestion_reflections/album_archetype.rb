module IngestionReflections
  class AlbumArchetype < Default
    def record_class = ::AlbumArchetype

    delegate_missing_to :record_class

    def create_finder = IngestionFinder::AlbumArchetype.new

    def delegated_base_reflections = factory.create(:archetype)
  end
end
