module Import
  class Handler
    def initialize(facade)
      @facade = facade
    end

    attr_reader :facade

    def call
      # collect || persist!
      record = collect
      return record if record

      session.lock
      persist!
    end

    def collect
      # TODO: Build Import::CollectorAction via factory
      Import::CollectAction.call(session, facade: facade)
    end

    def persist!
      Import::PersistAction.call(session, facade: facade)
    end

    def session
      # FIXME: choose the right session-class
      @session ||= Import::MusicbrainzSession.new(:evil_fake_import_order)
    end
  end
end
