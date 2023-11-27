module Import
  class From
    def initialize(fake_import_order)
      @fake_import_order = fake_import_order
    end

    def musicbrainz
      @musicbrainz ||= build_musicbrainz_handler
    end

    private

    attr_reader :import_order

    def build_musicbrainz_handler
      factory = MusicbrainzFactory.new # (import_order)
      FromHandler.new(factory)
    end
  end
end
