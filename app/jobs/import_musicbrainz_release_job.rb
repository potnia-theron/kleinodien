class ImportMusicbrainzReleaseJob < ApplicationJob
  include ActiveJob::Continuable

  queue_as :default

  def perform(import_order)
    reflections_factory = ModelReflections::Factory.new
    reflections = reflections_factory.create(import_order.target_kind)

    facade_factory = MusicbrainzFacade::Factory.new(import_order, reflections_factory)
    facade = facade_factory.create(import_order.target_kind, musicbrainz_code: import_order.code)

    step :find_existing do
      import_order.find_existing!
      finder_factory = RecordFinder::Factory.new
      finder = finder_factory.create(import_order.target_kind)
      @entity = finder.call(facade)
    end

    step :buffering do
      import_order.buffering!
      kit = ImportKit.build(facade, reflections)
      Importer.call(kit)
    end

    step :persisting do
      import_order.persisting!
      kit = ImportKit.build(facade, reflections)
      @entity = Importer.call(kit, persister: Importer::Persister.new)
    end

    step :done do
      import_order.done!
      @entity
    end
  end
end
