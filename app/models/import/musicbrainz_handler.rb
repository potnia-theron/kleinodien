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

    def lock
      Rails.logger.info("locking session")
      session.lock
    end

    def create
      Import::MusicbrainzCreator.call(session, facade)
    end

    def facade
      camel_kind = import_order.kind.camelize
      facade_class = "Import::Musicbrainz#{camel_kind}Facade".constantize
      facade_class.new(session, code: import_order.code)
    end

    def session
      @session ||= Import::MusicbrainzSession.new(import_order)
    end
  end
end
