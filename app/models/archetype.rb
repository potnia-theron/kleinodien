class Archetype < ApplicationRecord
  delegated_type :archetypeable, types: %w[AlbumArchetype]

  belongs_to :artist_credit, optional: true
end
