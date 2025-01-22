module LayeredImport
  class ParticipantReflections < Participant
    def self.inherent_attribute_names
      attribute_names
        .without("id", "created_at", "updated_at")
        .reject { |attr| attr.end_with? "_id" }
    end

    def self.belong_to_associations = []

    def self.foreign_attribute_names = []

    def self.has_many_associations = []
  end
end
