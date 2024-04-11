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
      collect_action.call
    end

    def create
      ActiveRecord::Base.transaction do
        create_action.call
      end
    end

    def collect_action
      session.build_collect_action(facade: facade)
    end

    def create_action
      session.build_create_action(facade: facade)
    end

    delegate :lock, to: :session

    def session
      # FIXME: choose the right session-class
      @session ||= Import::MusicbrainzSession.new(:evil_fake_import_order)
    end
  end
end
