module Import
  class Session
    def initialize(import_order)
      @import_order = import_order
    end

    def musicbrainz
      @musicbrainz ||= build_ancillary("Import::MusicbrainzFactory")
    end

    def build_collect_action(...)
      Import::CollectAction.new(session, ...)
    end

    def build_create_action(...)
      Import::CreateAction.new(session, ...)
    end

    private

    attr_reader :import_order

    def build_ancillary(factory_name)
      factory = factory_name.constantize.new(self)
      SessionAncillary.new(factory)
    end
  end
end
