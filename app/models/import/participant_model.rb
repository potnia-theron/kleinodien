module Import
  class ParticipantModel
    def model = Participant

    def belongs_to_associations
      model.reflect_on_all_associations(:belongs_to)
    end

    # def has_many_associations
    # def has_and_belongs_to_many_associations
    # ... should be in an module

    def code_columns
      model.attribute_names.filter { |attr_name| attr_name.ends_with?("_code") }
    end
  end
end
