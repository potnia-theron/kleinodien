module IngestionReflections
  module Associations
    class AlbumArchetype < Default
      def record_class = ::AlbumArchetype

      def delegated_base_reflections = factory.create(:archetype)
    end
  end
end
