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
    assert_difference("ImportOrder.count") do
      post import_orders_url, params: {import_order: {code: @import_order.code, import_order_id: @import_order.import_order_id, kind: @import_order.kind, state: @import_order.state, type: @import_order.type, uri: @import_order.uri, user_id: @import_order.user_id}}
    end

    # Does not work because UUIDs are used as primary key
    # From https://guides.rubyonrails.org/active_record_querying.html#last
    # > The last method finds the last record ordered by primary key (default).
    # assert_redirected_to import_order_url(ImportOrder.last)
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
    patch import_order_url(@import_order), params: {import_order: {code: @import_order.code, import_order_id: @import_order.import_order_id, kind: @import_order.kind, state: @import_order.state, type: @import_order.type, uri: @import_order.uri, user_id: @import_order.user_id}}
    assert_redirected_to import_order_url(@import_order)
  end

  test "should destroy import_order" do
    assert_difference("ImportOrder.count", -1) do
      delete import_order_url(@import_order)
    end

    assert_redirected_to import_orders_url
  end
end
