class ArtistCreditParticipant < ApplicationRecord
  belongs_to :artist_credit
  belongs_to :participant
end
