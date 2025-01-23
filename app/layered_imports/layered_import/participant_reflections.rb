module LayeredImport
  class ParticipantReflections
    delegate_missing_to Participant

    def inherent_attribute_names
      attribute_names
        .without("id", "created_at", "updated_at")
        .reject { |attr| attr.end_with? "_id" }
    end

    def belong_to_associations = []

    def foreign_attribute_names = []

    def has_many_associations = []
  end
end
