module Import
  class AdapterLayer
    def initialize(order)
      @order ||= order
    end

    attr_reader :order

    def supply_record(...)
      Import::RecordSupplier.new(self, ...).supply_record
    end

    def build_delegated_base(...) = Import::DelegatedBaseBuilder.new(self, ...).supply_delegated_base

    def build_foreign_base_assigner(...) = Import::ForeignBaseAssigner.new(self, ...)

    def build_foreign_attribute_assigner(...) = Import::ForeignAttributeAssigner.new(self, ...)

    def build_has_many_builder(...) = Import::HasManyBuilder.new(self, ...)

    def build_record(...) = Import::RecordBuilder.new(self, ...).call

    def build_reflections_for(kind)
      "Import::#{kind.to_s.underscore.classify}Reflections".constantize.new
    end

    def find_record(...)
      Import::RecordFinder.new(self, ...).find
    end

    def facade_layer
      @facade_layer ||= Import::FacadeLayer.new(order)
    end
  end
end
