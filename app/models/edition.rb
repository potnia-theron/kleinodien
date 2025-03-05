class Edition < ApplicationRecord
  delegated_type :editionable, types: %w[AlbumEdition SongEdition]

  belongs_to :archetype
end
