require "application_system_test_case"

class ArtistCreditParticipantsTest < ApplicationSystemTestCase
  setup do
    @artist_credit_participant = artist_credit_participants(:one)
  end

  test "visiting the index" do
    visit artist_credit_participants_url
    assert_selector "h1", text: "Artist credit participants"
  end

  test "should create artist credit participant" do
    visit artist_credit_participants_url
    click_on "New artist credit participant"

    fill_in "Artist credit", with: @artist_credit_participant.artist_credit_id
    fill_in "Join phrase", with: @artist_credit_participant.join_phrase
    fill_in "Participant", with: @artist_credit_participant.participant_id
    fill_in "Position", with: @artist_credit_participant.position
    click_on "Create Artist credit participant"

    assert_text "Artist credit participant was successfully created"
    click_on "Back"
  end

  test "should update Artist credit participant" do
    visit artist_credit_participant_url(@artist_credit_participant)
    click_on "Edit this artist credit participant", match: :first

    fill_in "Artist credit", with: @artist_credit_participant.artist_credit_id
    fill_in "Join phrase", with: @artist_credit_participant.join_phrase
    fill_in "Participant", with: @artist_credit_participant.participant_id
    fill_in "Position", with: @artist_credit_participant.position
    click_on "Update Artist credit participant"

    assert_text "Artist credit participant was successfully updated"
    click_on "Back"
  end

  test "should destroy Artist credit participant" do
    visit artist_credit_participant_url(@artist_credit_participant)
    click_on "Destroy this artist credit participant", match: :first

    assert_text "Artist credit participant was successfully destroyed"
  end
end
