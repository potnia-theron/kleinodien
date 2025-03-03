module Import
  class AdapterLayer
    def initialize(order)
      @order ||= order
    end

    attr_reader :order

    def supply_record(...)
      Import::RecordSupplier.new(self, ...).supply_record
    end

    def assign_foreign_attribute(...) = Import::ForeignAttributeAssigner.new(self, ...).assign

    def assign_foreign_base(...) = Import::ForeignBaseAssigner.new(self, ...).assign

    def build_delegated_base(...) = Import::DelegatedBaseBuilder.new(self, ...).supply_delegated_base

    def build_has_many_associations(...) = Import::HasManyBuilder.new(self, ...).build_many

    def build_record(...) = Import::RecordBuilder.new(self, ...).call

    def build_reflections_for(kind)
      "Import::#{kind.to_s.underscore.classify}Reflections".constantize.new
    end

    def find_record(...) = Import::RecordFinder.new(self, ...).find

    def facade_layer
      @facade_layer ||= Import::FacadeLayer.new(order)
    end
  end
end
