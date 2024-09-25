module Import
  class MusicbrainzHandler
    def initialize(import_order)
      @import_order = import_order
    end

    attr_reader :import_order

    def call
      Rails.logger.info("starting import from MusicBrainz")
      record = find || collect
      return record if record && record.class.is_a?(ApplicationRecord)

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

    def find
      Rails.logger.info("trying to find excisting record")
      finder.call
    end

    def collect_action
      Rails.logger.info("collecting data")
      session.build_collect_action(facade: facade)
    end

    def create_action
      Rails.logger.info("persisting data")
      session.build_create_action(facade: facade)
    end

    def finder
      session.build_finder(facade)
    end

    def facade
      @facade ||= build_facade
    end

    def build_facade
      camel_kind = import_order.kind.camelize
      facade_class = "Import::Musicbrainz#{camel_kind}Facade".constantize
      facade_class.new(session, code: import_order.code)
    end

    # delegate :lock, to: :session
    def lock
      Rails.logger.info("locking session")
      session.lock
    end

    def session
      @session ||= Import::MusicbrainzSession.new(import_order)
    end
  end
end
