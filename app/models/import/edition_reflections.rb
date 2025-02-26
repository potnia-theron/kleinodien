module Import
  class EditionReflections
    include Concerns::Reflectable

    delegate_missing_to Edition

    def after_belongs_to_associations(associations)
      associations
        .reject { |association| association.name == :editionable }
        .reject { |association| association.name == :archetype }
    end
  end
end
