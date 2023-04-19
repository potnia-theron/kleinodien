require "application_system_test_case"

class MusicBrainzImportOrdersTest < ApplicationSystemTestCase
  setup do
    @music_brainz_import_order = music_brainz_import_orders(:one)
  end

  test "visiting the index" do
    visit music_brainz_import_orders_url
    assert_selector "h1", text: "Music brainz import orders"
  end

  test "should create music brainz import order" do
    visit music_brainz_import_orders_url
    click_on "New music brainz import order"

    click_on "Create Music brainz import order"

    assert_text "Music brainz import order was successfully created"
    click_on "Back"
  end

  test "should update Music brainz import order" do
    visit music_brainz_import_order_url(@music_brainz_import_order)
    click_on "Edit this music brainz import order", match: :first

    click_on "Update Music brainz import order"

    assert_text "Music brainz import order was successfully updated"
    click_on "Back"
  end

  test "should destroy Music brainz import order" do
    visit music_brainz_import_order_url(@music_brainz_import_order)
    click_on "Destroy this music brainz import order", match: :first

    assert_text "Music brainz import order was successfully destroyed"
  end
end
