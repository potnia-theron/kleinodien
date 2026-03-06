module IngestionReflections
  module Associations
    class EditionPosition < Default
      def record_class = ::EditionPosition

      def belongs_to = super.reject { it.name == :section }
    end
  end
end
