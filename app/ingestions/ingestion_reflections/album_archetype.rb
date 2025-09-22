module IngestionReflections
  class AlbumArchetype
    include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    delegate_missing_to ::AlbumArchetype

    def create_finder = IngestionFinder::AlbumArchetype.new

    def delegated_base
      return unless delegated_base_class

      factory.create(delegated_base_class.name)
    end

    private

    attr_reader :factory
  end
end
