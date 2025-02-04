module LayeredImport
  class ArtistCreditReflections
    include Concerns::Reflectable

    delegate_missing_to ArtistCredit

    def belong_to_associations = []

    def foreign_attribute_names
      attribute_names.select { |attr| attr.end_with? "_id" }
    end

    def has_many_associations = reflect_on_all_associations(:has_many)
  end
end
