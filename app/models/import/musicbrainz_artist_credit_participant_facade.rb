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

    # FIXME: implement #join_phrase
    def join_phrase = nil

    def participant
      session.build_facade(Import::MusicbrainzParticipantFacade, code: data.artist.id)
    end

    def model_class = ArtistCreditParticipant

    def properties
      @properties ||= session.build_properties(model_class)
    end
  end
end
