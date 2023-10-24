require "application_system_test_case"

class ParticipantsTest < ApplicationSystemTestCase
  setup do
    @participant = participants(:one)
  end

  test "visiting the index" do
    visit participants_url
    assert_selector "h1", text: "Participants"
  end

  test "should create participant" do
    visit participants_url
    click_on "New participant"

    fill_in "Begin date", with: @participant.begin_date
    fill_in "Begin date mask", with: @participant.begin_date_mask
    fill_in "Disambiguation", with: @participant.disambiguation
    fill_in "Discogs code", with: @participant.discogs_code
    fill_in "End date", with: @participant.end_date
    fill_in "End date mask", with: @participant.end_date_mask
    fill_in "Imdb code", with: @participant.imdb_code
    fill_in "Import order", with: @participant.import_order_id
    fill_in "Musicbrainz code", with: @participant.musicbrainz_code
    fill_in "Name", with: @participant.name
    fill_in "Sort name", with: @participant.sort_name
    fill_in "Tmdb code", with: @participant.tmdb_code
    fill_in "Wikidata code", with: @participant.wikidata_code
    click_on "Create Participant"

    assert_text "Participant was successfully created"
    click_on "Back"
  end

  test "should update Participant" do
    visit participant_url(@participant)
    click_on "Edit this participant", match: :first

    fill_in "Begin date", with: @participant.begin_date
    fill_in "Begin date mask", with: @participant.begin_date_mask
    fill_in "Disambiguation", with: @participant.disambiguation
    fill_in "Discogs code", with: @participant.discogs_code
    fill_in "End date", with: @participant.end_date
    fill_in "End date mask", with: @participant.end_date_mask
    fill_in "Imdb code", with: @participant.imdb_code
    fill_in "Import order", with: @participant.import_order_id
    fill_in "Musicbrainz code", with: @participant.musicbrainz_code
    fill_in "Name", with: @participant.name
    fill_in "Sort name", with: @participant.sort_name
    fill_in "Tmdb code", with: @participant.tmdb_code
    fill_in "Wikidata code", with: @participant.wikidata_code
    click_on "Update Participant"

    assert_text "Participant was successfully updated"
    click_on "Back"
  end

  test "should destroy Participant" do
    visit participant_url(@participant)
    click_on "Destroy this participant", match: :first

    assert_text "Participant was successfully destroyed"
  end
end
