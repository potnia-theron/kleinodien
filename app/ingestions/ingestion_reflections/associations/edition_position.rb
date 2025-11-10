module IngestionReflections
  module Associations
    class EditionPosition < Base
      def record_class = ::EditionPosition

      def belongs_to_associations
        super.reject { it.name == :section }
      end
    end
  end
end
