module Import
  class AdapterLayer
    def initialize(order)
      @order ||= order
    end

    attr_reader :order

    def supply_record(...)
      Import::RecordSupplier.new(self, ...).supply_record
    end

    def supply_delegated_base(facade, reflections)
      delegated_base_class = reflections.delegated_base_class
      return unless delegated_base_class

      Import::DelegatedBaseSupplier.new(self, facade, reflections).supply_delegated_base
    end

    def build_foreign_base_assigner(...)
      Import::ForeignBaseAssigner.new(self, ...)
    end

    def build_foreign_attribute_assigner(...)
      Import::ForeignAttributeAssigner.new(self, ...)
    end

    def build_has_many_builder(...)
      Import::HasManyBuilder.new(self, ...)
    end

    def find_record(...)
      Import::RecordFinder.new(self, ...).find
    end

    def facade_layer
      @facade_layer ||= Import::FacadeLayer.new(order)
    end

    def build_reflections_for(kind)
      "Import::#{kind.to_s.underscore.classify}Reflections".constantize.new
    end
  end
end
