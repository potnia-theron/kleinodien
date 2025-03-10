module Import
  class AdapterLayer
    def initialize(order)
      @order ||= order
    end

    attr_reader :order

    def supply_record(...)
      Import::RecordSupplier.new(self, ...).supply_record
    end

    def assign_foreign_base(...) = Import::ForeignBaseAssigner.call(self, ...)

    def assign_foreign_attribute(...) = Import::ForeignAttributeAssigner.call(self, ...)

    def assign_delegate_base_to_delegated_base(...) = DelegatedBaseToDelegatedBaseAssigner.call(self, ...)

    def build_delegated_base(...) = Import::DelegatedBaseBuilder.call(self, ...)

    def build_has_many_associations(...) = Import::HasManyBuilder.call(self, ...)

    def build_record(...) = Import::RecordBuilder.call(self, ...)

    def build_reflections_for(kind)
      "Import::#{kind.to_s.underscore.classify}Reflections".constantize.new
    end

    def find_record(...) = Import::RecordFinder.call(self, ...)

    def facade_layer
      @facade_layer ||= Import::FacadeLayer.new(order)
    end
  end
end
