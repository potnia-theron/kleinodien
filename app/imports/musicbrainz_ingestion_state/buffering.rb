module MusicbrainzIngestionState
  class Buffering
    def initialize(factory)
      @factory = factory
    end

    def call
      import_order.buffering!
      kit = ImportKit.build(facade, reflections)
      Importer.call(kit)
      persisting = factory.create(:persisting)
      persisting.call
    end

    private

    attr_reader :factory

    delegate_missing_to :factory
  end
end
