class Edition < ApplicationRecord
  delegated_type :editionable, types: %w[AlbumEdition SongEdition]

  belongs_to :archetype
  has_many :sections, class_name: "EditionSection", dependent: :destroy
end
