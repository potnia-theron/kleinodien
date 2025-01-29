module LayeredImport::Concerns
  module Reflectable
    extend ActiveSupport::Concern

    def has_one_associations = reflect_on_all_associations(:has_one)

    def delegated_head
      delegated_type_of&.active_record
    end

    def writer_on_delegated_head
      delegated_type_attr_name = delegated_type_of.name
      return unless delegated_type_attr_name

      "#{delegated_type_attr_name}="
    end

    private

    def delegated_type_of
      results = has_one_associations.filter { |assoc| assoc.inverse_of.options[:polymorphic] }

      return if results.none?
      raise "too many delegated_types" if results.length > 1

      results.first.inverse_of
    end
  end
end
