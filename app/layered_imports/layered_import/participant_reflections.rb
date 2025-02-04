module LayeredImport
  class ParticipantReflections
    include Concerns::Reflectable

    delegate_missing_to Participant

    def has_many_associations = []
  end
end
