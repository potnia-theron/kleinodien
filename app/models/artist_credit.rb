class ArtistCredit < ApplicationRecord
  has_many :participants, class_name: "ArtistCreditParticipant", dependent: :destroy

  before_validation :ensure_name_has_a_value

  private

  def ensure_name_has_a_value
    return if name.present?

    joinables = participants.map { |acp| [acp.name, join_phrase_for(acp)] }.flatten
    joinables.pop # ignore the last join_phrase
    self.name = joinables.join
  end

  private

  def join_phrase_for(artist_credit_participant)
    artist_credit_participant.join_phrase || " "
  end
end
