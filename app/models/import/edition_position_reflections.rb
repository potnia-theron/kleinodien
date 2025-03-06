module Import
  class EditionPositionReflections
    include Concerns::Reflectable

    delegate_missing_to "EditionPosition"

    def after_belongs_to_associations(associations)
      associations
        .reject { |association| association.name == :edition }
        .reject { |association| association.name == :section }
    end
  end
end
