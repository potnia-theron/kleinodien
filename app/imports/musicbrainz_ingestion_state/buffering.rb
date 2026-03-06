module MusicbrainzIngestionState
  class Buffering
    def initialize(factory)
      @factory = factory
    end

    def call
      import_order.buffering!
      kit = IngestionKit.build(facade, reflections)
      Ingestor.call(kit)
      persisting = factory.create(:persisting)
      persisting.call
    end

    private

    attr_reader :factory

    delegate_missing_to :factory
  end
end
