module ModelReflections
  class AlbumArchetype < Default
    def delegated_base_reflections = factory.create(:archetype)
  end
end
