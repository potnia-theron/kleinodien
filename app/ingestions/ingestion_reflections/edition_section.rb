module IngestionReflections
  class EditionSection
    include Concerns::Reflectable

    delegate_missing_to ::EditionSection

    def after_belongs_to_associations(associations)
      associations.reject { |association| association.name == :edition }
    end

    def after_inherent_attribute_names(names)
      names.reject { |name| name == "positions_count" }
    end
  end
end
