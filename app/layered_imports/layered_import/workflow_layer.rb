module LayeredImport
  class WorkflowLayer
    def initialize(import_order)
      @import_order ||= import_order
    end

    attr_reader :import_order

    def build_buffer_filler
      proc { true }
    end

    def build_buffer_persister
      proc { true }
    end
  end
end
