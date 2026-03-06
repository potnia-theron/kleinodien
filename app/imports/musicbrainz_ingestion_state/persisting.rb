module MusicbrainzIngestionState
  class Persisting
    def initialize(factory)
      @factory = factory
    end

    def call
      import_order.persisting!
      kit = ImportKit.build(facade, reflections)
      entity = Importer.call(kit, persister: persister)
      done.call(entity)
    end

    private

    attr_reader :factory
    delegate_missing_to :factory

    def done = factory.create(:done)

    def persister = Importer::Persister.new
  end
end
