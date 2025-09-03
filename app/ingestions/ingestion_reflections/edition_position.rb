module IngestionReflections
  class EditionPosition
    include Concerns::Reflectable

    delegate_missing_to ::EditionPosition

    def after_belongs_to_associations(associations)
      associations
        .reject { |association| association.name == :edition }
        .reject { |association| association.name == :section }
    end

    def foreign_base_associations
      reflect_on_all_associations(:belongs_to)
        .select { |association| association.name == :edition }
    end
  end
end
