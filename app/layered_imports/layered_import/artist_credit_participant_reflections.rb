module LayeredImport
  class ArtistCreditParticipantReflections < ArtistCreditParticipant
    def self.inherent_attribute_names
      attribute_names
        .without("id", "created_at", "updated_at")
        .reject { |attr| attr.end_with? "_id" }
        .reject { |attr| attr.end_with? "_accuracy" }
        .map { |attr| (attr == "begin_date") ? "begins_at" : attr }
        .map { |attr| (attr == "end_date") ? "ends_at" : attr }
    end

    def self.has_many_associations
      []
    end

    def self.belong_to_associations
      reflect_on_all_associations(:belongs_to)
        .reject { |association| association.name == :artist_credit }
    end

    def self.foreign_attribute_names
      reflect_on_all_associations(:belongs_to)
        .map(&:name)
        .without(:artist_credit)
        .map(&:to_s)
    end
  end
end
