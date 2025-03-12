module Import
  class MusicbrainzWorkflow
    def initialize(order)
      @order = order
    end

    attr_reader :order

    def call
      find || create
    end

    private

    def find
      adapter_layer.find_entity(order.kind, musicbrainz_code: order.code)
    end

    def create
      fill_buffer
      persist
    end

    def fill_buffer
      order.buffering!
      adapter_layer.supply_entity(order.kind, musicbrainz_code: order.code)
    end

    def persist
      order.persisting!

      entity = persist_within_transaction

      order.done!

      entity
    end

    def adapter_layer
      @adapter_layer ||= Import::AdapterLayer.new(order)
    end

    def persist_within_transaction
      ActiveRecord::Base.transaction { supply_persisted_entity }
    end

    def supply_persisted_entity
      adapter_layer.with(supply_persisted: true) do |adapter|
        adapter.supply_entity(order.kind, musicbrainz_code: order.code)
      end
    end
  end
end
