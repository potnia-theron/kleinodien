module Import
  class ArchetypeReflections
    include Concerns::Reflectable

    delegate_missing_to Archetype

    def after_belongs_to_associations(associations)
      associations.reject { |association| association.name == :archetypeable }
    end

    def after_has_many_associations(associations)
      associations.reject { |association| association.name == :editions }
    end
  end
end
