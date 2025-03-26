module Import::Concerns
  module Reflectable
    extend ActiveSupport::Concern

    # def has_one_associations = reflect_on_all_associations(:has_one)
    def has_one_associations
      # TODO: how to handle "central" in imports
      reflect_on_all_associations(:has_one).reject { it.name == :central }
    end

    def delegated_of_association_writer
      return unless delegated_of_association

      "#{delegated_of_association.name}="
    end

    def delegated_of_association
      results = has_one_associations.filter { |assoc| assoc.inverse_of.options[:polymorphic] }

      return if results.none?
      raise "too many delegated_types" if results.length > 1

      results.first
    end

    def delegated_base_class
      @delegated_base_class ||= delegated_of_association&.inverse_of&.active_record
    end

    def delegated_base_associations = []

    def foreign_base_associations = []

    def inherent_attribute_names
      names = attribute_names
        .without("id", "created_at", "updated_at")
        .reject { |attr| attr.end_with? "_id" }

      after_inherent_attribute_names(names)
    end

    def after_inherent_attribute_names(names) = names

    def belong_to_associations
      associations = reflect_on_all_associations(:belongs_to)
        .reject { |association| association.class_name == "ImportOrder" }

      after_belongs_to_associations(associations)
    end

    def after_belongs_to_associations(associations) = associations

    def has_many_associations
      associations = reflect_on_all_associations(:has_many)
        .reject { it.name == :links }
        .reject { it.name == :backlinks }

      after_has_many_associations(associations)
    end

    def after_has_many_associations(associations) = associations

    def linkable?
      reflect_on_all_associations(:has_many).any? { |association| association.name == :links }
    end
  end
end
