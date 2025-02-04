module LayeredImport
  class ParticipantReflections
    include Concerns::Reflectable

    delegate_missing_to Participant

    def after_has_many_associations(associations)
      associations.reject { |association| association.name == :artist_credit_participants }
    end
  end
end
