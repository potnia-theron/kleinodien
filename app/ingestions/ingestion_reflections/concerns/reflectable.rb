module IngestionReflections::Concerns
  module Reflectable
    extend ActiveSupport::Concern

    delegate :create, to: :factory

    def delegated_base_reflections = nil

    def create_finder
      factory.create_finder(model_name)
    end

    def has_one_associations
      reflect_on_all_associations(:has_one).reject { it.name == :central }
    end

    def delegated_of_association
      results = has_one_associations.filter { it.inverse_of.options[:polymorphic] }

      return if results.none?
      raise "too many delegated_types" if results.length > 1

      results.first
    end

    def delegated_base_associations = []

    def foreign_base_associations = []

    def delegated_type_association
      reflect_on_all_associations(:belongs_to)
        .filter(&:foreign_type)
        .tap { raise "too many delegated types" if it.length > 1 }
        .first
    end

    def inherent_attribute_names
      attribute_names
        .without("id", "created_at", "updated_at")
        .reject { it.end_with? "_id" }
    end

    def belongs_to_associations
      reflect_on_all_associations(:belongs_to)
        .reject { it.class_name == "ImportOrder" }
    end

    def belongs_to_association_reflections
      belongs_to_associations
        .index_by(&:name)
        .transform_values { factory.create(it.class_name) }
    end

    def has_many_associations
      reflect_on_all_associations(:has_many)
        .reject { it.name == :links }
        .reject { it.name == :backlinks }
    end

    def linkable?
      reflect_on_all_associations(:has_many).any? { it.name == :links }
    end
  end
end
