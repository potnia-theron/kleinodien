module LayeredImport
  class MusicbrainzAlbumArchetypeFacade
    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options
    end

    attr_reader :facade_layer, :options

    delegate_missing_to :facade_layer

    def cheap_codes = {}

    def all_codes = {}

    def discogs_code = nil

    def musicbrainz_code = options[:code]

    def wikidata_code = nil
  end
end
