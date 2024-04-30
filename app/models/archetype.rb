class Archetype < ApplicationRecord
  delegated_type :archetypeable, types: %w[AlbumArchetype]
end
