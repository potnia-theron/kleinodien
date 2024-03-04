module Import
  class MusicbrainzArtistCreditParticipantFacade
    def initialize(session, data:)
      @session = session
      @data = data
    end

    attr_reader :data, :session

    def model = ArtistCreditParticipant

    def belongs_to_associations
      model.reflect_on_all_associations(:belongs_to)
    end
  end
end
