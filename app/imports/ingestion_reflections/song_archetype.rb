module IngestionReflections
  class SongArchetype < Default
    def delegated_base = factory.create(:archetype)
  end
end
