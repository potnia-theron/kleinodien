module Import
  class MusicbrainzArtistCreditFacade
    def initialize(session, data:)
      @data = data
      @session = session
    end

    attr_reader :data, :session

    def model_class = ArtistCredit

    def properties
      @properties ||= session.build_properties(model_class)
    end

    delegate_missing_to :properties

    def all_codes = nil

    def intrinsic_code = nil

    def attributes
      properties.coining_attributes.index_with { |attr_name| send(attr_name) }
    end

    # TODO: To Import has_many_associations remove this method
    def has_many_associations = []

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
