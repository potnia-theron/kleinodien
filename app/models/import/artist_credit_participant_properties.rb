module Import
  class ArtistCreditParticipantProperties
    include Concerns::Reflectable

    def intrinsic_code_attributes
      [:musicbrainz_code]
    end
  end
end
