module MusicbrainzIngestionState
  class Factory
    def initialize(import_order)
      @import_order = import_order
    end

    def create(desired_state)
      "#{my_module}::#{desired_state.to_s.classify}"
        .constantize
        .new(self)
    end

    attr_reader :import_order

    def facade = @facade ||= facade_factory.create(target_kind, musicbrainz_code: code)

    def ingestion
      @ingestion ||= Ingestion::Switch.new(facade, reflections)
    end

    def reflections = @reflections ||= reflections_factory.create(target_kind)

    private

    def code = import_order.code

    def facade_factory = @facade_factory ||= MusicbrainzFacade::Factory.new(import_order, reflections_factory)

    def my_module = @my_module ||= self.class.name.sub(/::.+\z/, "")

    # def reflections_factory = @reflections_factory ||= IngestionReflections::Factory.new(import_order)
    def reflections_factory = @reflections_factory ||= IngestionReflections::Factory.new

    def target_kind = import_order.target_kind
  end
end
