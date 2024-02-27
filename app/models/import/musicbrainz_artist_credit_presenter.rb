module Import
  class MusicbrainzArtistCreditPresenter
    def initialize(session, data:)
      @data = data
      @session = session
    end

    attr_reader :data, :session

    def model = ArtistCredit

    def all_codes = nil

    def intrinsic_code = nil

    def attributes
      {
        name: name
      }
    end

    def belongs_to_association_names
      []
    end

    def has_many_associations
      assos = model.reflect_on_all_associations(:has_many)
      inverse = assos.map do |asso|
        # needs:
        # - [ ] ActiveRecord-class of the referenced association
        # - [ ] name of the ArtistCredit-attribute in the ActiveRecord-class
        class_name = asso.class_name
        inverse_name = asso.inverse_of.name
        [class_name, inverse_name]
      end
      # debugger
      assos
    end

    def name
      tokens = data.map { |ac| [ac.name, ac.joinphrase] }.flatten

      last_token = tokens.pop
      raise "last participant must not contain anything" if last_token.present?

      tokens.join("")
    end

    # def participants
    #   factory.build_presenter_list(ArtistCreditParticipant, data)
    # end

    # def raw_participants
    #   data.artist_credit
    # end
  end
end
