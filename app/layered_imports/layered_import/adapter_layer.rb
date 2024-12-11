module LayeredImport
  class AdapterLayer
    def initialize(order)
      @order ||= order
    end

    attr_reader :order

    def build_record(...)
      LayeredImport::BuildRecord.call(self, ...)
    end

    def facade_layer
      @facade_layer ||= LayeredImport::FacadeLayer.new(order)
    end
  end
end
