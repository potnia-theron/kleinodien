module IngestionReflections
  class Edition
    include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    def record_class = ::Edition

    delegate_missing_to :record_class

    Association = Data.define(:association, :factory) do
      delegate_missing_to :association

      def delegated_base_reader = :archetype

      def delegated_type_reader = :editionable_type

      def delegated_class_for(entity)
        entity.send(delegated_type_reader).sub("Edition", "Archetype")
      end

      def delegated_class_reflections_for(entity) = factory.create(delegated_class_for(entity))
    end

    delegate_missing_to ::Edition

    def belongs_to_associations
      super.reject { it.name == :editionable }
    end

    def delegated_base_associations
      association = reflect_on_all_associations(:belongs_to)
        .find { it.name == :archetype }

      [Association.new(association, factory)]
    end

    attr_reader :factory

    def create_finder = IngestionFinder::Edition.new
  end
end
