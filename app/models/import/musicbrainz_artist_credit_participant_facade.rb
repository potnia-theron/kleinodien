module Import
  class MusicbrainzArtistCreditParticipantFacade
    def initialize(session, data:)
      @session = session
      @data = data
    end

    attr_reader :data, :session

    def model = ArtistCreditParticipant

    def model_class = ArtistCreditParticipant

    def properties
      @properties ||= session.build_properties(model_class)
    end

    delegate_missing_to :properties
  end
end
