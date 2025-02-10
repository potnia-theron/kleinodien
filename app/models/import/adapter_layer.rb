module Import
  class AdapterLayer
    def initialize(order)
      @order ||= order
    end

    attr_reader :order

    def build_finder_class(reflections)
      "Import::#{reflections.base_class.name}Finder".constantize
    end

    def build_record(...)
      Import::RecordBuilder.new(self, ...).build_record
    end

    def build_delegated_head(facade, reflections)
      head_class = reflections
        .delegated_of_association
        &.inverse_of
        &.active_record

      return unless head_class

      Import::DelegatedHeadBuilder.new(self, facade, head_class).build_delegated_head
    end

    def build_foreign_attribute_assigner(...)
      Import::ForeignAttributeAssigner.new(self, ...)
    end

    def build_has_many_builder(...)
      Import::HasManyBuilder.new(self, ...)
    end

    def find_record(kind, options)
      reflections = build_reflections_for(kind)
      facade = facade_layer.build_facade(reflections, options)
      finder_class = build_finder_class(reflections)
      finder_class.new(order, facade: facade).find
    end

    def facade_layer
      @facade_layer ||= Import::FacadeLayer.new(order)
    end

    def build_reflections_for(kind)
      "Import::#{kind.to_s.classify}Reflections".constantize.new
    end
  end
end
