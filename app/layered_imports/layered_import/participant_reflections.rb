module LayeredImport
  class ParticipantReflections < Participant
    def self.inherent_attribute_names
      attribute_names
        .without("id", "created_at", "updated_at")
        .reject { |attr| attr.end_with? "_id" }
        .reject { |attr| attr.end_with? "_accuracy" }
        .map { |attr| (attr == "begin_date") ? "begins_at" : attr }
        .map { |attr| (attr == "end_date") ? "ends_at" : attr }
    end

    def self.foreign_attribute_names = []

    def self.has_many_associations = []
  end
end
