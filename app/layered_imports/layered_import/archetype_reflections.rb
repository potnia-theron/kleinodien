module LayeredImport
  class ArchetypeReflections
    include Concerns::Reflectable

    delegate_missing_to Archetype

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
