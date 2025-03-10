module Import
  class SongArchetypeReflections
    include Concerns::Reflectable

    delegate_missing_to SongArchetype

    def after_has_many_associations(associations)
      associations.reject { |association| association.name == :sections }
    end
  end
end
