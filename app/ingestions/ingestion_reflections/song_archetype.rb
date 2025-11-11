module IngestionReflections
  class SongArchetype < Default
    def record_class = ::SongArchetype

    delegate_missing_to :record_class

    def delegated_base = factory.create(:archetype)
  end
end
