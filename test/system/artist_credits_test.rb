require "application_system_test_case"

class ArtistCreditsTest < ApplicationSystemTestCase
  setup do
    @artist_credit = artist_credits(:one)
  end

  test "visiting the index" do
    visit artist_credits_url
    assert_selector "h1", text: "Artist credits"
  end

  test "should create artist credit" do
    visit artist_credits_url
    click_on "New artist credit"

    fill_in "Name", with: @artist_credit.name
    click_on "Create Artist credit"

    assert_text "Artist credit was successfully created"
    click_on "Back"
  end

  test "should update Artist credit" do
    visit artist_credit_url(@artist_credit)
    click_on "Edit this artist credit", match: :first

    fill_in "Name", with: @artist_credit.name
    click_on "Update Artist credit"

    assert_text "Artist credit was successfully updated"
    click_on "Back"
  end

  test "should destroy Artist credit" do
    visit artist_credit_url(@artist_credit)
    click_on "Destroy this artist credit", match: :first

    assert_text "Artist credit was successfully destroyed"
  end
end
