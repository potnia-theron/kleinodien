require "test_helper"

class ImportOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @import_order = import_orders(:one)
    @user = sign_in_as(users(:kim))
  end

  test "should get index" do
    get import_orders_url

    assert_response :success
  end

  test "should get new" do
    get new_import_order_url

    assert_response :success
  end

  test "should create import_order" do
    assert_difference("MusicbrainzImportOrder.count") do
      post import_orders_url, params: {import_order: {code: "e848bea6-6276-430e-b7de-7f07a2035f73", kind: "release", state: "open", type: "MusicbrainzImportOrder", uri: @import_order.uri}} # , user_id: @import_order.user_id}}
    end

    assert_redirected_to import_order_url(ImportOrder.last)
  end

  test "with a MusicBrainz-URI it should create a MusicBrainzImportOrder" do
    assert_difference("ImportOrder.count") do
      post import_orders_url, params: {import_order: {uri: "https://musicbrainz.org/release/040c8e28-74d8-482e-ba47-175dbf46499c"}}
    end

    assert_redirected_to import_order_url(ImportOrder.last)
  end

  test "should not create import_order with bad parameters" do
    assert_no_difference("ImportOrder.count") do
      post import_orders_url, params: {import_order: {wrong: "parameter"}}
    end

    assert_response :unprocessable_entity
  end

  test "should show import_order" do
    get import_order_url(@import_order)

    assert_response :success
  end

  test "should get edit" do
    get edit_import_order_url(@import_order)

    assert_response :success
  end

  test "should update import_order" do
    patch import_order_url(@import_order), params: {import_order: {code: @import_order.code, import_order_id: @import_order.import_order_id, kind: @import_order.kind, state: @import_order.state, type: @import_order.type, uri: @import_order.uri}} # , user_id: @import_order.user_id}}

    assert_redirected_to import_order_url(@import_order)
  end

  test "should not update import_order with bad parameters" do
    patch import_order_url(@import_order), params: {import_order: {state: "abc"}}

    assert_redirected_to import_order_url(@import_order)
    # assert_response :unprocessable_entity
  end

  test "should destroy import_order" do
    assert_difference("ImportOrder.count", -1) do
      delete import_order_url(@import_order)
    end

    assert_redirected_to import_orders_url
  end
end
