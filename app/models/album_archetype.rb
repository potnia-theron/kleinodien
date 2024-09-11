class AlbumArchetype < ApplicationRecord
  include Archetypeable

  belongs_to :artist_credit, optional: true
end
