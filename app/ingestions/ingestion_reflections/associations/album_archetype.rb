module IngestionReflections
  module Associations
    class AlbumArchetype < Base
      def record_class = ::AlbumArchetype

      def delegated_base_reflections = factory.create(:archetype)
    end
  end
end
