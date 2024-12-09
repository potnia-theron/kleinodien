module LayeredImport
  class MusicbrainzWorkflow
    def initialize(import_order)
      @import_order = import_order
    end

    attr_reader :import_order

    def call
      fill_buffer
      persist
    end

    private

    def fill_buffer
      import_order.buffering!
      workflow_layer.build_buffer_filler.call
      import_order.buffered!
    end

    def persist
      import_order.persisting!
      workflow_layer.build_buffer_persister.call
      import_order.persisted!
      true
    end

    def adapter_layer
      @adapter_layer ||= LayeredImport::AdapterLayer.new(import_order)
    end

    def workflow_layer
      @workflow_layer ||= LayeredImport::WorkflowLayer.new(import_order)
    end
  end
end
