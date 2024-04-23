class Archetype < ApplicationRecord
  belongs_to :artist_credit, optional: true
  delegated_type :archetypeable, types: %w[AlbumArchetype]
end
