module LayeredImport
  class MusicbrainzArtistCreditFacade
    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options
    end

    attr_reader :facade_layer, :options
    delegate_missing_to :facade_layer

    def data
      @data ||= _data
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
      data.map.each_with_index { |ac_participant, idx| ac_participant.merge({position: idx}) }
    end

    private

    def _data
      if options.is_a? Array
        options
      else
        # TODO: this will fail on an ArtistCredit of a :recording
        request_layer.get(:release, options[:musicbrainz_code])[:artist_credit]
      end
    end
  end
end
