module Import
  class Handler
    def initialize(presenter)
      @presenter = presenter
    end

    attr_reader :presenter

    def call
      collect || persist!
    end

    def collect
      collector.call
    end

    delegate :persist!, to: :persister

    def collector
      Import::Collector.new(session, presenter: presenter, model: presenter.model)
    end

    def persister
      Import::Persist.new(presenter)
    end

    def session
      # !!!!!!!!!!
      @session ||= Import::Session.new(:evil_fake_import_order, default_factory: :musicbrainz)
    end
  end
end
