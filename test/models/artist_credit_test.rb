require "test_helper"

class ArtistCreditTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "join names" do
    artist_credit = ArtistCredit.new

    participant = Participant.create!(name: "first", sort_name: "first")
    acp = ArtistCreditParticipant.new(participant: participant, join_phrase: " feat. ", position: 0)
    artist_credit.artist_credit_participants << acp

    participant = Participant.create!(name: "second", sort_name: "second")
    acp = ArtistCreditParticipant.new(participant: participant, join_phrase: " bad ", position: 1)
    artist_credit.artist_credit_participants << acp

    assert_equal "first feat. second", artist_credit.name
  end
end
