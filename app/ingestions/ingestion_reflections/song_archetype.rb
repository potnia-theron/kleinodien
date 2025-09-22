module IngestionReflections
  class SongArchetype
    include Concerns::Reflectable
    def initialize(factory)
      @factory = factory
    end

    delegate_missing_to ::SongArchetype

    attr_reader :factory

    def delegated_base = factory.create(:archetype)
  end
end
