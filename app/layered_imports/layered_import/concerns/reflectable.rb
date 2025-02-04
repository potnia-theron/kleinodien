module LayeredImport::Concerns
  module Reflectable
    extend ActiveSupport::Concern

    def has_one_associations = reflect_on_all_associations(:has_one)

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
  end
end
