module Import
  class DelegatedBaseBuilder < Import::RecordBuilder
    def initialize(adapter_layer, facade, kind)
      @adapter_layer = adapter_layer
      @facade = facade
      @kind = kind
    end

    def supply_delegated_base
      assign_foreign_attributes
      assign_foreign_bases
      build_has_many_records

      record
    end

    private

    def assign_foreign_bases
      return unless reflections.respond_to? :delegated_base_associations

      reflections.delegated_base_associations.each do |association|
        adapter_layer.build_foreign_base_assigner(association, facade, record).assign
      end
    end
  end
end
