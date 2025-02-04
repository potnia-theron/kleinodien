module LayeredImport
  class ParticipantReflections
    include Concerns::Reflectable

    delegate_missing_to Participant

    def belong_to_associations = []

    def foreign_attribute_names = []

    def has_many_associations = []
  end
end
