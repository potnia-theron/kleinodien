module Import
  class MusicbrainzArtistCreditParticipantFacade
    def initialize(session, data:)
      @session = session
      @data = data
    end

    attr_reader :data, :session
  end
end
