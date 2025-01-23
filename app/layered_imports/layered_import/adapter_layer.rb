module LayeredImport
  class AdapterLayer
    def initialize(order)
      @order ||= order
    end

    attr_reader :order

    def build_finder_class(reflections)
      "LayeredImport::#{reflections.base_class.name}Finder".constantize
    end

    def build_record(...)
      LayeredImport::BuildRecord.call(self, ...)
    end

    def create_foreign_attribute_assigner(...)
      LayeredImport::ForeignAttributeAssigner.new(self, ...)
    end

    def create_has_many_builder(...)
      LayeredImport::HasManyBuilder.new(self, ...)
    end

    def find_record(kind, options)
      reflections = build_reflections_for(kind)
      facade = facade_layer.build_facade(reflections, options)
      finder_class = build_finder_class(reflections)
      finder_class.new(order, facade: facade).find
    end

    def facade_layer
      @facade_layer ||= LayeredImport::FacadeLayer.new(order)
    end

    def build_reflections_for(kind)
      ReflectionsBuilder.build_reflection(kind)
    end
  end
end
