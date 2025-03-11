require "application_system_test_case"

class EditionSectionsTest < ApplicationSystemTestCase
  setup do
    @edition_section = edition_sections(:one)
  end

  test "visiting the index" do
    visit edition_sections_url
    assert_selector "h1", text: "Edition sections"
  end

  test "should create edition section" do
    visit edition_sections_url
    click_on "New edition section"

    fill_in "Alphanumeric", with: @edition_section.alphanumeric
    fill_in "Edition", with: @edition_section.edition_id
    fill_in "Level", with: @edition_section.level
    fill_in "No", with: @edition_section.no
    fill_in "Positions count", with: @edition_section.positions_count
    click_on "Create Edition section"

    assert_text "Edition section was successfully created"
    click_on "Back"
  end

  test "should update Edition section" do
    visit edition_section_url(@edition_section)
    click_on "Edit this edition section", match: :first

    fill_in "Alphanumeric", with: @edition_section.alphanumeric
    fill_in "Edition", with: @edition_section.edition_id
    fill_in "Level", with: @edition_section.level
    fill_in "No", with: @edition_section.no
    fill_in "Positions count", with: @edition_section.positions_count
    click_on "Update Edition section"

    assert_text "Edition section was successfully updated"
    click_on "Back"
  end

  test "should destroy Edition section" do
    visit edition_section_url(@edition_section)
    click_on "Destroy this edition section", match: :first

    assert_text "Edition section was successfully destroyed"
  end
end
