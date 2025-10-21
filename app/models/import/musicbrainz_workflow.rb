module Import
  class MusicbrainzWorkflow
    include Callable

    def initialize(order)
      @order = order
    end

    attr_reader :order

    def call
      import_order = order.import_order
      factory = MusicbrainzIngestionState::Factory.new(import_order)
      open_state = factory.create(:open)
      final_state = open_state.call
      final_state.result
    end
  end
end
