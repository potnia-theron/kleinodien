class Archetype < ApplicationRecord
  belongs_to :artist_credit, optional: true
end
