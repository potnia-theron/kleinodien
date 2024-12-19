module LayeredImport
  class MusicbrainzArtistCreditFacade
    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options
    end

    attr_reader :facade_layer, :options
    delegate_missing_to :facade_layer

    def data
      @data ||= request_layer.get(:release, options[:musicbrainz_code])[:artist_credit]
    end

    def name
      data
        .map { |ac| [ac[:name], ac[:joinphrase]] }
        .flatten
        .tap { |tokens| raise "last participant must not contain anything" if tokens.last.present? }
        .tap { |tokens| tokens.pop }
        .join("")
    end

    def participants
      data.map { |participant| request_layer.get(:artist, participant[:artist][:id]) }
    end
  end
end
