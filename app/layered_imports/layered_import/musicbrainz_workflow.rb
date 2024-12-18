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
      # TODO: choose the type of the record by ImportOrder#kind
      # workflow_layer.build_record(:participant, musicbrainz_code: order.code)
      adapter_layer.build_record(record_type, musicbrainz_code: order.code)
      # adapter_layer.build_record(:participant, musicbrainz_code: order.code)
      # order.buffered!
    end

    def persist
      order.persisting!
      # workflow_layer.build_buffer_persister.call
      record = adapter_layer.build_record(record_type, musicbrainz_code: order.code)
      record.save!
      record
      # order.persisted!
      # fake = Object.new
      # fake.define_singleton_method :name, proc { "NoMeansNo" }
      # fake
    end

    def adapter_layer
      @adapter_layer ||= LayeredImport::AdapterLayer.new(order)
    end

    def record_type
      # TODO: remove #record_type
      # This is a temporary solution
      # An ImportOrder#kind shouldn't be an artist_credit or an participant
      (order.kind == "participant") ? :participant : :artist_credit
    end

    def workflow_layer
      @workflow_layer ||= LayeredImport::WorkflowLayer.new(order)
    end
  end
end
