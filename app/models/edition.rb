class Edition < ApplicationRecord
  delegated_type :editionable, types: %w[AlbumEdition]

  belongs_to :archetype
end
