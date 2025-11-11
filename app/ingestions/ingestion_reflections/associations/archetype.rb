module IngestionReflections
  module Associations
    class Archetype < Base
      def record_class = ::Archetype

      def belongs_to = super.reject { it.name == :archetypeable }

      def has_many = super.reject { it.name == :editions }
    end
  end
end
