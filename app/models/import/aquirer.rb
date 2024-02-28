module Import
  class Aquirer
    def initialize(presenter)
      @presenter = presenter
    end

    attr_reader :presenter

    def aquire
      prepare || persist!
    end

    def prepare
      perparer.call
    end

    delegate :persist!, to: :persister

    def perparer
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
