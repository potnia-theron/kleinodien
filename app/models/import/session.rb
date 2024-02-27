module Import
  class Session
    def initialize(import_order, default_factory: nil)
      @import_order = import_order

      # TODO: bad code
      if default_factory
        @default_factory = send default_factory
      end
    end

    def musicbrainz
      @musicbrainz ||= build_ancillary("Import::MusicbrainzFactory")
    end

    private

    attr_reader :default_factory, :import_order
    delegate_missing_to :default_factory

    def build_ancillary(factory_name)
      # factory = factory_name.constantize.new(import_order)
      factory = factory_name.constantize.new(self)
      SessionAncillary.new(factory)
    end
  end
end
