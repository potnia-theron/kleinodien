module IngestionReflections
  class SongArchetype < Base
    # include Concerns::Reflectable
    def initialize(factory)
      @factory = factory
    end

    def record_class = ::SongArchetype

    delegate_missing_to :record_class

    attr_reader :factory

    def delegated_base = factory.create(:archetype)
  end
end
