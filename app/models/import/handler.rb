module Import
  class Handler
    def initialize(facade)
      @facade = facade
    end

    attr_reader :facade

    def call
      record = collect
      return record if record

      lock

      create
    end

    def collect
      # TODO: Build Import::CollectAction via factory
      Import::CollectAction.call(session, facade: facade)
    end

    def create
      ActiveRecord::Base.transaction do
        create_action.call
      end
    end

    def create_action
      # TODO: Build Import::CreateAction via factory
      Import::CreateAction.new(session, facade: facade)
    end

    delegate :lock, to: :session

    def session
      # FIXME: choose the right session-class
      @session ||= Import::MusicbrainzSession.new(:evil_fake_import_order)
    end
  end
end
