module Import
  class AdapterLayer
    def initialize(order)
      @order ||= order
    end

    attr_reader :order

    def supply_record(...)
      Import::RecordSupplier.new(self, ...).supply_record
    end

    def supply_delegated_head(facade, reflections)
      head_class = reflections.head_class
      return unless head_class

      Import::DelegatedHeadSupplier.new(self, facade, reflections).supply_delegated_head
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
