module MusicbrainzIngestionState
  class Persisting
    def initialize(factory)
      @factory = factory
    end

    def call
      ingestion.persisting!
      import_order.persisting!
      entity = ingestion.call
      done.call(entity)
    end

    private

    attr_reader :factory
    delegate_missing_to :factory

    def done = factory.create(:done)
  end
end
