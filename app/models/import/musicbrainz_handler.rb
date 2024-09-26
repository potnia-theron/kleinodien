module Import
  class MusicbrainzHandler
    def initialize(import_order)
      @import_order = import_order
    end

    attr_reader :import_order

    def call
      Rails.logger.info("starting import from MusicBrainz")

      if (entry = collect)
        entry
      else
        lock
        create
      end
    end

    def collect
      Import::MusicbrainzCollector.call(session, facade)
    end

    def create
      ActiveRecord::Base.transaction do
        create_action.call
      end
    end

    def create_action
      Rails.logger.info("persisting data")
      session.build_create_action(facade: facade)
    end

    def facade
      @facade ||= build_facade
    end

    def build_facade
      camel_kind = import_order.kind.camelize
      facade_class = "Import::Musicbrainz#{camel_kind}Facade".constantize
      facade_class.new(session, code: import_order.code)
    end

    def lock
      Rails.logger.info("locking session")
      session.lock
    end

    def session
      @session ||= Import::MusicbrainzSession.new(import_order)
    end
  end
end
