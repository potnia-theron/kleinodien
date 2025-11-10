module IngestionReflections
  module Associations
    class Edition < Base
      def record_class = ::Edition

      def belongs_to_associations
        super.reject { it.name == :editionable }
      end
    end
  end
end
