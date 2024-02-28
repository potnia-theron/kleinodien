module Import
  class Handler
    def initialize(facade)
      @facade = facade
    end

    attr_reader :facade

    def call
      collect || persist!
    end

    def collect
      collector.call
    end

    delegate :persist!, to: :persister

    def collector
      Import::Collector.new(session, facade: facade, model: facade.model)
    end

    def persister
      Import::Persist.new(facade)
    end

    def session
      # !!!!!!!!!!
      @session ||= Import::Session.new(:evil_fake_import_order, default_factory: :musicbrainz)
    end
  end
end
