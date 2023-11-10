class ArtistCredit < ApplicationRecord
  has_many :artist_credit_participants, dependent: :destroy
end
