module Import
  class ArtistCreditParticipantProperties
    include Concerns::Reflectable

    def belongs_to_associations
      super.reject { |association| association.name == :artist_credit }
    end
  end
end
