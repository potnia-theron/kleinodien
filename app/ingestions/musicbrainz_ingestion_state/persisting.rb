module MusicbrainzIngestionState
  class Persisting
    def initialize(factory)
      @factory = factory
    end

    def call
      import_order.persisting!
      kit = IngestionKit::Single.new(facade, reflections)
      entity = Ingestor.call(kit, persister: persister)
      done.call(entity)
    end

    private

    attr_reader :factory
    delegate_missing_to :factory

    def done = factory.create(:done)

    def persister = Ingestion::Persister.new
  end
end
