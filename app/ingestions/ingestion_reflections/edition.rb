module IngestionReflections
  class Edition
    include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    delegate_missing_to ::Edition

    Association = Data.define(:association, :factory) do
      delegate_missing_to :association

      def delegated_base_reader = :archetype

      def delegated_type_reader = :editionable_type

      def delegated_class_for(entity)
        entity.send(delegated_type_reader).sub("Edition", "Archetype")
      end

      def delegated_class_reflections_for(entity) = factory.create(delegated_class_for(entity))

      def delegated_base_reflections = factory.create(:archetype)
    end

    delegate_missing_to ::Edition

    def after_belongs_to_associations(associations)
      associations
        .reject { |association| association.name == :editionable }
        .reject { |association| association.name == :archetype }
    end

    def delegated_base_associations
      association = reflect_on_all_associations(:belongs_to)
        .find { |association| association.name == :archetype }

      [Association.new(association, factory)]
    end

    attr_reader :factory

    def create_finder = IngestionFinder::Edition.new
  end
end
