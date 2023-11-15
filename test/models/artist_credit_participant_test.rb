require "test_helper"

class ArtistCreditParticipantTest < ActiveSupport::TestCase
  setup do
    @acp = ArtistCreditParticipant.new(
      artist_credit: artist_credits(:one),
      participant: participants(:one),
      position: 0
    )
  end

  test "with valid attributes" do
    assert_predicate @acp, :valid?
  end

  test "not valid without an ArtistCredit" do
    @acp.artist_credit = nil

    assert_not_predicate @acp, :valid?
  end

  test "not valid without a Participant" do
    @acp.participant = nil

    assert_not_predicate @acp, :valid?
  end

  test "not valid without an position" do
    @acp.position = nil

    assert_not_predicate @acp, :valid?
  end

  test "position is unique in the scope of ArtistCredit" do
    other_acp = ArtistCreditParticipant.new(
      artist_credit: artist_credits(:one), # same ArtistCredit as in @acp
      participant: participants(:two),     # ... but another Participant
      position: 0                          # ... on the same position as in @acp
    )

    assert_predicate other_acp, :valid?

    @acp.save!

    assert_not_predicate other_acp, :valid?
  end

  test "delegates name to Participant" do
    @acp.participant = Participant.create!(name: "Superstar")

    assert_equal "Superstar", @acp.name
  end
end
