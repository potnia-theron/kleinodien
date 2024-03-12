module Import
  class MusicbrainzArtistCreditParticipantFacade
    def initialize(session, data:, **options)
      @session = session
      @data = data
      @options = options
    end

    attr_reader :data, :options, :session

    def attributes
      properties.coining_attributes.index_with { |attr_name| send(attr_name) }
    end

    def artist_credit
      debugger
      options[:artist_credit]
    end

    def join_phrase = nil

    def participant
      session.build_facade(Import::MusicbrainzParticipantFacade, code: data.artist.id)
    end

    # BUG: #position is just a fake
    @@pos = 0
    def position
      @@pos += 1
    end
    # def position = 1
    # def position
    #   debugger
    # end

    def model_class = ArtistCreditParticipant

    def properties
      @properties ||= session.build_properties(model_class)
    end
  end
end
