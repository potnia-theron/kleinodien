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

    delegate :buffered?, to: :participant_facade

    def artist_credit_facade
      options[:artist_credit_facade]
    end

    def join_phrase
      data[:joinphrase]
    end

    def participant_facade
      session.build_facade(Participant, code: data.dig(:artist, :id))
    end
  end
end
