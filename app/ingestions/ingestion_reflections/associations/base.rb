module IngestionReflections
  module Associations
    class Base
      def initialize(factory)
        @factory = factory
      end

      # record_class must be defined by the child
      delegate_missing_to :record_class

      def has_one
        reflect_on_all_associations(:has_one).reject { it.name == :central }
      end

      def delegated_base_reflections = nil

      def delegated_of
        results = has_one.filter { it.inverse_of.options[:polymorphic] }

        return if results.none?
        raise "too many delegated_types" if results.length > 1

        results.first
      end

      def delegated_base = []

      def foreign_base = []

      def delegated_type
        reflect_on_all_associations(:belongs_to)
          .filter(&:foreign_type)
          .tap { raise "too many delegated types" if it.length > 1 }
          .first
      end

      def belongs_to
        reflect_on_all_associations(:belongs_to)
          .reject { it.class_name == "ImportOrder" }
      end

      def belongs_to_reflections
        belongs_to
          .index_by(&:name)
          .transform_values { factory.create(it.class_name) }
      end

      def has_many
        reflect_on_all_associations(:has_many)
          .reject { it.name == :links }
          .reject { it.name == :backlinks }
      end

      private

      attr_reader :factory
    end
  end
end
