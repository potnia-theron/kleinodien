module LayeredImport
  class AdapterLayer
    def initialize(import_order)
      @import_order ||= import_order
    end

    attr_reader :import_order
  end
end
