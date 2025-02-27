module Import
  class EditionReflections
    Association = Data.define(:association, :delegated_type_reader) do
      delegate_missing_to :association
    end

    include Concerns::Reflectable

    delegate_missing_to Edition

    def after_belongs_to_associations(associations)
      associations
        .reject { |association| association.name == :editionable }
        .reject { |association| association.name == :archetype }
    end

    def delegated_head_associations
      association = Edition
        .reflect_on_all_associations(:belongs_to)
        .find { |association| association.name == :archetype }

      [Association.new(association, :editionable_type)]
    end
  end
end
