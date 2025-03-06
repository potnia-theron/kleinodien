module Import
  class EditionSectionReflections
    include Concerns::Reflectable

    delegate_missing_to "EditionSection"

    def after_belongs_to_associations(associations)
      associations.reject { |association| association.name == :edition }
    end

    # def after_has_many_associations(associations)
    #   # TODO: This is a hack to avoid the positions association
    #   associations.reject { |association| association.name == :positions }
    # end

    def after_inherent_attribute_names(names)
      names.reject { |name| name == "positions_count" }
    end
  end
end
