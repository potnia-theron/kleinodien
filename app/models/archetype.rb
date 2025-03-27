class Archetype < ApplicationRecord
  include Centralable
  include Linkable

  delegated_type :archetypeable, types: %w[AlbumArchetype SongArchetype]

  belongs_to :artist_credit, optional: true
  has_many :editions
end
