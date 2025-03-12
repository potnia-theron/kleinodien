module Import
  class EditionReflections
    Association = Data.define(:association) do
      delegate_missing_to :association

      def delegated_base_reader = :archetype

      def delegated_type_reader = :editionable_type

      def delegated_class_for(entity)
        entity.send(delegated_type_reader).sub("Edition", "Archetype")
      end
    end

    include Concerns::Reflectable

    delegate_missing_to Edition

    def after_belongs_to_associations(associations)
      associations
        .reject { |association| association.name == :editionable }
        .reject { |association| association.name == :archetype }
    end

    def delegated_base_associations
      association = Edition
        .reflect_on_all_associations(:belongs_to)
        .find { |association| association.name == :archetype }

      [Association.new(association)]
    end
  end
end
