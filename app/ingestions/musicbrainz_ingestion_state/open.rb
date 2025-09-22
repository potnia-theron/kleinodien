module MusicbrainzIngestionState
  class Open
    def initialize(factory)
      @factory = factory
    end

    def call
      factory.import_order.find_existing!
      result = factory.create(:find_existing).call

      if result
        # TODO: handle result
      else
        factory.create(:buffering).call
      end
    end

    private

    attr_reader :factory
  end
end
