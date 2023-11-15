class ArtistCreditParticipant < ApplicationRecord
  belongs_to :artist_credit
  belongs_to :participant

  validates :position, presence: true, uniqueness: {scope: :artist_credit}

  delegate :name, to: :participant
end
