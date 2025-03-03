module Import
  class DelegatedBaseSupplier < Import::RecordBuilder
    def initialize(adapter_layer, facade, delegated_type_reflections)
      @adapter_layer = adapter_layer
      @facade = facade
      @delegated_type_reflections = delegated_type_reflections
    end

    def supply_delegated_base
      assign_foreign_attributes
      assign_foreign_bases
      build_has_many_records

      record
    end

    private

    attr_reader :delegated_type_reflections, :facade

    def reflections
      build_reflections_for delegated_type_reflections.delegated_base_class
    end
  end
end
