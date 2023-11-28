module Import
  class From
    def initialize(import_order)
      @import_order = import_order
    end

    def musicbrainz
      @musicbrainz ||= build_handler("Import::MusicbrainzFactory")
    end

    private

    attr_reader :import_order

    def build_handler(factory_name)
      factory = factory_name.constantize.new(import_order)
      FromHandler.new(factory)
    end
  end
end
