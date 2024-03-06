module Import
  class MusicbrainzArtistCreditParticipantFacade
    def initialize(session, data:)
      @session = session
      @data = data
    end

    attr_reader :data, :session

    def attributes
      properties.coining_attributes.index_with { |attr_name| send(attr_name) }
    end

    def join_phrase = nil

    def position = nil

    def model_class = ArtistCreditParticipant
    delegate_missing_to :properties

    def properties
      @properties ||= session.build_properties(model_class)
    end
  end
end
