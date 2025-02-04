module LayeredImport
  class ArchetypeReflections
    include Concerns::Reflectable

    delegate_missing_to Archetype

    def after_belongs_to_associations(associations)
      associations
        .reject { |association| association.name == :archetypeable }
        # TODO: stop rejecting ArtistCredit
        .reject { |association| association.name == :artist_credit }
    end

    # def foreign_attribute_names = []

    def has_many_associations = []
  end
end
