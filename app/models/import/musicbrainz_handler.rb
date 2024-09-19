module Import
  class MusicbrainzHandler
    def initialize(import_order)
      @import_order = import_order
    end

    attr_reader :import_order

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

    def facade
      camel_kind = import_order.kind.camelize
      facade_class = "Import::Musicbrainz#{camel_kind}Facade".constantize
      facade_class.new(session, code: import_order.code)
    end

    delegate :lock, to: :session

    def session
      # FIXME: choose the right session-class
      @session ||= Import::MusicbrainzSession.new(:evil_fake_import_order)
    end
  end
end
