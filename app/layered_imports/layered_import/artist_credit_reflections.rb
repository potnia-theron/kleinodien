module LayeredImport
  class ArtistCreditReflections < ArtistCredit
    def self.inherent_attribute_names
      attribute_names
        .without("id", "created_at", "updated_at")
        .reject { |attr| attr.end_with? "_id" }
        .reject { |attr| attr.end_with? "_accuracy" }
        .map { |attr| (attr == "begin_date") ? "begins_at" : attr }
        .map { |attr| (attr == "end_date") ? "ends_at" : attr }
    end

    def self.foreign_attribute_names
      attribute_names.select { |attr| attr.end_with? "_id" }
    end

    def self.has_many_associations = reflect_on_all_associations(:has_many)
  end
end
