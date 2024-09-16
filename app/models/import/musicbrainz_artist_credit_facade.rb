module Import
  class MusicbrainzArtistCreditFacade
    def initialize(session, data:, **options)
      @session = session
      @data = data
      @options = options
    end

    attr_reader :data, :options, :session

    def model_class = ArtistCredit

    def all_codes = nil

    def intrinsic_code = nil

    def name
      tokens = data.map { |ac| [ac[:name], ac[:joinphrase]] }.flatten

      last_token = tokens.pop
      raise "last participant must not contain anything" if last_token.present?

      tokens.join("")
    end

    def participants
      session.build_facade_list(
        data: data, model: ArtistCreditParticipant, artist_credit_facade: self
      )
    end
  end
end
