module LayeredImport
  class MusicbrainzWorkflow
    def initialize(order)
      @order = order
    end

    attr_reader :order

    def start
      fill_buffer
      persist
    end

    private

    def fill_buffer
      order.buffering!
      adapter_layer.build_record(order.kind, musicbrainz_code: order.code)
      # order.buffered!
    end

    def persist
      order.persisting!
      record = adapter_layer.build_record(order.kind, musicbrainz_code: order.code)
      record.save!
      record
      # order.persisted!
    end

    def adapter_layer
      @adapter_layer ||= LayeredImport::AdapterLayer.new(order)
    end

    def workflow_layer
      @workflow_layer ||= LayeredImport::WorkflowLayer.new(order)
    end
  end
end
