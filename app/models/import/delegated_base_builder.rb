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
  end
end
