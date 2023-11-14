require "test_helper"

class ArtistCreditParticipantTest < ActiveSupport::TestCase
  test "delegates name to Participant" do
    artist_credit = ArtistCredit.create!(name: "C-List celebrity")
    participant = Participant.create!(name: "Superstar")

    artist_credit_participant = ArtistCreditParticipant.new(artist_credit: artist_credit, participant: participant, position: 0)

    assert_equal "Superstar", artist_credit_participant.name
  end
end
