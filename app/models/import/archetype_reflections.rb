module Import
  class ArchetypeReflections
    include Concerns::Reflectable

    delegate_missing_to Archetype

    def after_belongs_to_associations(associations)
      associations
        .reject { |association| association.name == :archetypeable }
    end
  end
end
