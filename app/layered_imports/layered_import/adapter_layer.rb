module LayeredImport
  class AdapterLayer
    def initialize(order)
      @order ||= order
    end

    attr_reader :order

    def build_record(...)
      LayeredImport::BuildRecord.call(self, ...)
    end

    def create_has_many_builder(...)
      LayeredImport::HasManyBuilder.new(self, ...)
    end

    def facade_layer
      @facade_layer ||= LayeredImport::FacadeLayer.new(order)
    end

    def build_reflections_for(model)
      model
        .to_s
        .classify
        .prepend("LayeredImport::")
        .concat("Reflections")
        .constantize
    end
  end
end
