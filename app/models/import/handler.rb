module Import
  class Handler
    def initialize(facade)
      @facade = facade
    end

    attr_reader :facade

    def call
      collect || create
    end

    def collect
      # TODO: Build Import::CollectAction via factory
      Import::CollectAction.call(session, facade: facade)
    end

    def create
      lock
      # TODO: Build Import::CreateAction via factory
      Import::PersistAction.call(session, facade: facade)
    end

    delegate :lock, to: :session

    def session
      # FIXME: choose the right session-class
      @session ||= Import::MusicbrainzSession.new(:evil_fake_import_order)
    end
  end
end
