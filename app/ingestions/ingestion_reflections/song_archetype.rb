module IngestionReflections
  class SongArchetype < Base
    def record_class = ::SongArchetype

    delegate_missing_to :record_class

    def delegated_base = factory.create(:archetype)
  end
end
