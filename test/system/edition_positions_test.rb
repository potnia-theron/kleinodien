require "application_system_test_case"

class EditionPositionsTest < ApplicationSystemTestCase
  setup do
    @edition_position = edition_positions(:one)
  end

  test "visiting the index" do
    visit edition_positions_url
    assert_selector "h1", text: "Edition positions"
  end

  test "should create edition position" do
    visit edition_positions_url
    click_on "New edition position"

    fill_in "Alphanumeric", with: @edition_position.alphanumeric
    fill_in "Edition", with: @edition_position.edition_id
    fill_in "Edition section", with: @edition_position.edition_section_id
    fill_in "No", with: @edition_position.no
    click_on "Create Edition position"

    assert_text "Edition position was successfully created"
    click_on "Back"
  end

  test "should update Edition position" do
    visit edition_position_url(@edition_position)
    click_on "Edit this edition position", match: :first

    fill_in "Alphanumeric", with: @edition_position.alphanumeric
    fill_in "Edition", with: @edition_position.edition_id
    fill_in "Edition section", with: @edition_position.edition_section_id
    fill_in "No", with: @edition_position.no
    click_on "Update Edition position"

    assert_text "Edition position was successfully updated"
    click_on "Back"
  end

  test "should destroy Edition position" do
    visit edition_position_url(@edition_position)
    click_on "Destroy this edition position", match: :first

    assert_text "Edition position was successfully destroyed"
  end
end
