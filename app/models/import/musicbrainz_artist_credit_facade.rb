module Import
  class MusicbrainzArtistCreditFacade
    def initialize(session, data:)
      @data = data
      @session = session
    end

    attr_reader :data, :session

    def model = ArtistCredit

    def model_class = ArtistCredit

    def properties
      @properties ||= session.build_properties(model_class)
    end

    delegate_missing_to :properties

    def all_codes = nil

    def intrinsic_code = nil

    def attributes
      {
        name: name
      }
    end

    def name
      tokens = data.map { |ac| [ac.name, ac.joinphrase] }.flatten

      last_token = tokens.pop
      raise "last participant must not contain anything" if last_token.present?

      tokens.join("")
    end

    def participants
      session.build_facade_list(data: data, model: ArtistCreditParticipant)
    end
  end
end
