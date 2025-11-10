module IngestionReflections
  module Associations
    class AlbumEdition < Base
      def record_class = ::AlbumEdition

      def delegated_base_reflections = factory.create(:edition)
    end
  end
end
