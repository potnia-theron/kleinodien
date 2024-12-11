module LayeredImport
  class AdapterLayer
    def initialize(import_order)
      @import_order ||= import_order
    end

    attr_reader :import_order

    def build_record(...)
      LayeredImport::BuildRecord.call(self, ...)
    end

    def facade_layer
      @facade_layer ||= LayeredImport::FacadeLayer.new(import_order)
    end
  end
end
