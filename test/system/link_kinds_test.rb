require "application_system_test_case"

class LinkKindsTest < ApplicationSystemTestCase
  setup do
    @link_kind = link_kinds(:one)
  end

  test "visiting the index" do
    visit link_kinds_url
    assert_selector "h1", text: "Link kinds"
  end

  test "should create link kind" do
    visit link_kinds_url
    click_on "New link kind"

    fill_in "Description", with: @link_kind.description
    fill_in "Link phrase", with: @link_kind.link_phrase
    fill_in "Long link phrase", with: @link_kind.long_link_phrase
    fill_in "Musicbrainz code", with: @link_kind.musicbrainz_code
    fill_in "Name", with: @link_kind.name
    fill_in "Reverse link phrase", with: @link_kind.reverse_link_phrase
    click_on "Create Link kind"

    assert_text "Link kind was successfully created"
    click_on "Back"
  end

  test "should update Link kind" do
    visit link_kind_url(@link_kind)
    click_on "Edit this link kind", match: :first

    fill_in "Description", with: @link_kind.description
    fill_in "Link phrase", with: @link_kind.link_phrase
    fill_in "Long link phrase", with: @link_kind.long_link_phrase
    fill_in "Musicbrainz code", with: @link_kind.musicbrainz_code
    fill_in "Name", with: @link_kind.name
    fill_in "Reverse link phrase", with: @link_kind.reverse_link_phrase
    click_on "Update Link kind"

    assert_text "Link kind was successfully updated"
    click_on "Back"
  end

  test "should destroy Link kind" do
    visit link_kind_url(@link_kind)
    click_on "Destroy this link kind", match: :first

    assert_text "Link kind was successfully destroyed"
  end
end
