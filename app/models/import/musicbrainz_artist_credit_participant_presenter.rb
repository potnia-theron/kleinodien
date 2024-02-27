module Import
  class MusicbrainzArtistCreditParticipantPresenter
    def initialize(session, data:)
      @session = session
      @data = data
    end

    attr_reader :data, :session
  end
end
