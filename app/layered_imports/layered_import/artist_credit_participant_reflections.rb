module LayeredImport
  class ArtistCreditParticipantReflections
    include Concerns::Reflectable

    delegate_missing_to ArtistCreditParticipant

    def after_belongs_to_associations(associations)
      associations.reject { |association| association.name == :artist_credit }
    end
  end
end
