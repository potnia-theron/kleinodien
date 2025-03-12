require "test_helper"

class ArtistCreditTest < ActiveSupport::TestCase
  test "without participants it's invalid" do
    artist_credit = ArtistCredit.new

    assert_not_predicate artist_credit, :valid?
  end

  test "join names" do
    artist_credit = ArtistCredit.new

    participant = Participant.new(name: "first")
    artist_credit.participants << ArtistCreditParticipant.new(participant: participant, join_phrase: " feat. ", position: 0)

    participant = Participant.new(name: "second")
    artist_credit.participants << ArtistCreditParticipant.new(participant: participant, position: 1)

    participant = Participant.new(name: "third")
    artist_credit.participants << ArtistCreditParticipant.new(participant: participant, position: 2)

    assert_predicate artist_credit, :valid?
    assert_equal "first feat. second third", artist_credit.name
  end

  test "name must be unique" do
    template_artist_credit = artist_credits(:one)

    artist_credit = ArtistCredit.new(name: template_artist_credit.name)
    assert_not_predicate artist_credit, :valid?
    assert_equal 1, artist_credit.errors.count
    assert_equal ["has already been taken"], artist_credit.errors[:name]
  end
end
