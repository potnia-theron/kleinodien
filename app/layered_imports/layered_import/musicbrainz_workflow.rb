module LayeredImport
  class MusicbrainzWorkflow
    def initialize(import_order)
      @import_order = import_order
    end

    attr_reader :import_order

    def start
      fill_buffer
      persist
    end

    private

    def fill_buffer
      import_order.buffering!
      # TODO: choose the type of the record by ImportOrder#kind
      # workflow_layer.build_record(:participant, musicbrainz_code: import_order.code)
      adapter_layer.build_record(:participant, musicbrainz_code: import_order.code)
      # import_order.buffered!
    end

    def persist
      import_order.persisting!
      workflow_layer.build_buffer_persister.call
      # import_order.persisted!
      fake = Object.new
      fake.define_singleton_method :name, proc { "NoMeansNo" }
      fake
    end

    def adapter_layer
      @adapter_layer ||= LayeredImport::AdapterLayer.new(import_order)
    end

    def workflow_layer
      @workflow_layer ||= LayeredImport::WorkflowLayer.new(import_order)
    end
  end
end
