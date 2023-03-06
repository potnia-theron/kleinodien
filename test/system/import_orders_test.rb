require "application_system_test_case"

class ImportOrdersTest < ApplicationSystemTestCase
  setup do
    @import_order = import_orders(:one)
  end

  test "visiting the index" do
    visit import_orders_url
    assert_selector "h1", text: "Import orders"
  end

  test "should create import order" do
    visit import_orders_url
    click_on "New import order"

    fill_in "Code", with: @import_order.code
    fill_in "Import order", with: @import_order.import_order_id
    fill_in "Kind", with: @import_order.kind
    fill_in "State", with: @import_order.state
    fill_in "Type", with: @import_order.type
    fill_in "Uri", with: @import_order.uri
    fill_in "User", with: @import_order.user_id
    click_on "Create Import order"

    assert_text "Import order was successfully created"
    click_on "Back"
  end

  test "should update Import order" do
    visit import_order_url(@import_order)
    click_on "Edit this import order", match: :first

    fill_in "Code", with: @import_order.code
    fill_in "Import order", with: @import_order.import_order_id
    fill_in "Kind", with: @import_order.kind
    fill_in "State", with: @import_order.state
    fill_in "Type", with: @import_order.type
    fill_in "Uri", with: @import_order.uri
    fill_in "User", with: @import_order.user_id
    click_on "Update Import order"

    assert_text "Import order was successfully updated"
    click_on "Back"
  end

  test "should destroy Import order" do
    visit import_order_url(@import_order)
    click_on "Destroy this import order", match: :first

    assert_text "Import order was successfully destroyed"
  end
end
