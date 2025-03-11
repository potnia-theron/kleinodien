module Import
  class MusicbrainzWorkflow
    def initialize(order)
      @order = order
    end

    attr_reader :order, :record

    def start
      find || create
    end

    private

    def find
      adapter_layer.find_record(order.kind, musicbrainz_code: order.code)
    end

    def create
      fill_buffer
      persist
    end

    def fill_buffer
      order.buffering!
      adapter_layer.supply_record(order.kind, musicbrainz_code: order.code)
    end

    def persist
      order.persisting!

      # record = adapter_layer.supply_record(order.kind, musicbrainz_code: order.code)
      # record.transaction do

      # end
      ActiveRecord::Base.transaction do
        @record = adapter_layer.with(supply_persisted: true) do |adapter|
          adapter.supply_record(order.kind, musicbrainz_code: order.code, persistent: true)
        end
      end

      order.done!

      record
    end

    def adapter_layer
      @adapter_layer ||= Import::AdapterLayer.new(order)
    end
  end
end
