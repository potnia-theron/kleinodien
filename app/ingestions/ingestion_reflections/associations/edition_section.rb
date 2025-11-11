module IngestionReflections
  module Associations
    class EditionSection < Base
      def record_class = ::EditionSection

      def belongs_to_associations = super.reject { it.name == :edition }

      def inherent_attribute_names = super.reject { it == "positions_count" }
    end
  end
end
