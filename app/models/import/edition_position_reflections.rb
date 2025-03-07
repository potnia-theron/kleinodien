module Import
  class EditionPositionReflections
    # Association = Data.define(:association) do
    #   delegate_missing_to :association

    #   def delegated_base_reader = :edition

    #   def delegated_type_reader = :editionable_type

    #   def delegated_class_for(record)
    #     record.send(delegated_type_reader).sub("Edition", "Archetype")
    #   end
    # end

    include Concerns::Reflectable

    delegate_missing_to "EditionPosition"

    def after_belongs_to_associations(associations)
      associations
        .reject { |association| association.name == :edition }
        .reject { |association| association.name == :section }
    end

    # def delegated_base_associations
    #   association = EditionPosition
    #     .reflect_on_all_associations(:belongs_to)
    #     .find { |association| association.name == :edition }

    #   x = Association.new(association)
    #   debugger
    #   # debugger
    #   [x]
    #   # [Association.new(association)]
    # end
  end
end
