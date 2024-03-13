module Import
  class MusicbrainzArtistCreditParticipantFacade
    include Concerns::Numerable

    def initialize(session, data:, **options)
      @session = session
      @data = data
      @options = options
    end

    attr_reader :data, :options, :session
    alias_method :position, :consecutive_number

    def model_class = ArtistCreditParticipant

    # FIXME: implement #join_phrase
    def join_phrase = nil

    def participant
      session.build_facade(Import::MusicbrainzParticipantFacade, code: data.artist.id)
    end
  end
end
