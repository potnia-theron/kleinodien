module Import
  class SongEditionReflections
    include Concerns::Reflectable

    delegate_missing_to SongEdition

    def after_has_many_associations(associations)
      associations
        .reject { |association| association.name == :sections }
    end
  end
end
