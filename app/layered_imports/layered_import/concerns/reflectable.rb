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
  end
end
