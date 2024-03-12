module Import
  class ArtistCreditParticipantProperties
    include Concerns::Reflectable

    def belongs_to_associations
      # debugger
      super.reject { |association| association.name == :artist_credit }
    end
  end
end
