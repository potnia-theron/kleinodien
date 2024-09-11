require "application_system_test_case"

class ArchetypesTest < ApplicationSystemTestCase
  setup do
    @archetype = archetypes(:one)
  end

  test "visiting the index" do
    visit archetypes_url
    assert_selector "h1", text: "Archetypes"
  end

  test "should create archetype" do
    visit archetypes_url
    click_on "New archetype"

    fill_in "Archetypeable", with: @archetype.archetypeable_id
    fill_in "Archetypeable type", with: @archetype.archetypeable_type
    fill_in "Artist credit", with: @archetype.artist_credit_id
    fill_in "Title", with: @archetype.title
    click_on "Create Archetype"

    assert_text "Archetype was successfully created"
    click_on "Back"
  end

  test "should update Archetype" do
    visit archetype_url(@archetype)
    click_on "Edit this archetype", match: :first

    fill_in "Archetypeable", with: @archetype.archetypeable_id
    fill_in "Archetypeable type", with: @archetype.archetypeable_type
    fill_in "Artist credit", with: @archetype.artist_credit_id
    fill_in "Title", with: @archetype.title
    click_on "Update Archetype"

    assert_text "Archetype was successfully updated"
    click_on "Back"
  end

  test "should destroy Archetype" do
    visit archetype_url(@archetype)
    click_on "Destroy this archetype", match: :first

    assert_text "Archetype was successfully destroyed"
  end
end
