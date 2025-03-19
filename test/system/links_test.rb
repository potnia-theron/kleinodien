require "application_system_test_case"

class LinksTest < ApplicationSystemTestCase
  setup do
    @link = links(:one)
  end

  test "visiting the index" do
    visit links_url
    assert_selector "h1", text: "Links"
  end

  test "should create link" do
    visit links_url
    click_on "New link"

    fill_in "Begin data", with: @link.begin_data
    fill_in "Begin date accuracy", with: @link.begin_date_accuracy
    fill_in "Destination", with: @link.destination_id
    fill_in "End date", with: @link.end_date
    fill_in "End date accuracy", with: @link.end_date_accuracy
    fill_in "Link kind", with: @link.link_kind_id
    fill_in "Source", with: @link.source_id
    click_on "Create Link"

    assert_text "Link was successfully created"
    click_on "Back"
  end

  test "should update Link" do
    visit link_url(@link)
    click_on "Edit this link", match: :first

    fill_in "Begin data", with: @link.begin_data
    fill_in "Begin date accuracy", with: @link.begin_date_accuracy
    fill_in "Destination", with: @link.destination_id
    fill_in "End date", with: @link.end_date
    fill_in "End date accuracy", with: @link.end_date_accuracy
    fill_in "Link kind", with: @link.link_kind_id
    fill_in "Source", with: @link.source_id
    click_on "Update Link"

    assert_text "Link was successfully updated"
    click_on "Back"
  end

  test "should destroy Link" do
    visit link_url(@link)
    click_on "Destroy this link", match: :first

    assert_text "Link was successfully destroyed"
  end
end
