module MusicbrainzIngestionState
  class Persisting
    def initialize(factory)
      @factory = factory
    end

    def call
      import_order.persisting!
      kit = Ingestion::Kit.new(facade, reflections, persister: persister)
      entity = Ingestion::RecordBuilder.call(kit)
      done.call(entity)
    end

    private

    attr_reader :factory
    delegate_missing_to :factory

    def done = factory.create(:done)

    def persister = Ingestion::Persister.new
  end
end
