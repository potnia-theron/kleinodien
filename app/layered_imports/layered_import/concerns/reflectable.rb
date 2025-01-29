module LayeredImport::Concerns
  module Reflectable
    extend ActiveSupport::Concern

    def has_one_associations = reflect_on_all_associations(:has_one)

    def delegated_type_of
      results = has_one_associations.filter { |assoc| assoc.inverse_of.options[:polymorphic] }

      return if results.none?
      raise "too many delegated_types" if results.length > 1

      results.first.inverse_of.active_record
    end
  end
end
