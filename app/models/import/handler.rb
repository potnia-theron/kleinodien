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
      Import::Collector.new(session, facade: facade)
    end

    def persister
      Import::Persist.new(session, facade: facade)
    end

    def session
      # FIXME: choose the right session-class
      @session ||= Import::MusicbrainzSession.new(:evil_fake_import_order)
    end
  end
end
