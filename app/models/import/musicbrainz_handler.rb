module Import
  class MusicbrainzHandler
    def self.call(...)
      new(...).call
    end

    def initialize(import_order)
      @import_order = import_order
    end

    attr_reader :import_order

    def call
      Rails.logger.info("starting import from Musicbrainz")

      if (entry = collect)
        [inspect, entry.inspect]
      else
        lock
        create
      end
    end

    def collect
      import_order.buffering!
      collector = session.build_collection_igniter(facade)
      collector.call
    end

    def lock
      Rails.logger.info("locking session")
      session.lock
    end

    def create
      import_order.persisting!
      kreator = session.build_creation_igniter(facade)

      if (result = kreator.call)
        import_order.done!
        result
      else
        import_order.failed!
      end
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
