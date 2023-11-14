class ArtistCredit < ApplicationRecord
  has_many :participants, class_name: "ArtistCreditParticipant", dependent: :destroy

  def name
    joinables = participants.map { |acp| [acp.name, join_phrase_for(acp)] }
    joinables = joinables.flatten
    joinables.pop # ignore the last join_phrase
    joinables.join
  end

  private

  def join_phrase_for(artist_credit_participant)
    artist_credit_participant.join_phrase || " "
  end
end
