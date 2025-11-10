module IngestionReflections
  module Associations
    class Archetype < Base
      def record_class = ::Archetype

      def belongs_to_associations
        super.reject { it.name == :archetypeable }
      end

      def has_many_associations
        super.reject { it.name == :editions }
      end

      # def delegated_base_associations
      #   association = reflect_on_all_associations(:belongs_to)
      #     .find { it.name == :archetype }

      #   [Association.new(association, factory)]
      # end
    end
  end
end
