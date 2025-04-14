require "test_helper"

class MusicbrainzImportOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @musicbrainz_import_order = musicbrainz_import_orders(:musicbrainz_one)
    # @user = sign_in_as(users(:kim))
  end

  test "should get index" do
    get musicbrainz_import_orders_url

    assert_response :success
  end

  test "should get new" do
    get new_musicbrainz_import_order_url

    assert_response :success
  end

  test "should create musicbrainz_import_order" do
    assert_difference("MusicbrainzImportOrder.count") do
      post musicbrainz_import_orders_url, params: {musicbrainz_import_order: {code: @musicbrainz_import_order.code, kind: @musicbrainz_import_order.kind}} # , user_id: @musicbrainz_import_order.user_id}}
    end

    assert_redirected_to musicbrainz_import_order_url(MusicbrainzImportOrder.last)
  end

  test "should not create musicbrainz_import_order with bad parameters" do
    assert_no_difference("MusicbrainzImportOrder.count") do
      post musicbrainz_import_orders_url, params: {musicbrainz_import_order: {bad: "evil"}}
    end

    assert_response :unprocessable_entity
  end

  test "should show musicbrainz_import_order" do
    get musicbrainz_import_order_url(@musicbrainz_import_order)

    assert_response :success
  end

  test "should get edit" do
    get edit_musicbrainz_import_order_url(@musicbrainz_import_order)

    assert_response :success
  end

  test "should update musicbrainz_import_order" do
    patch musicbrainz_import_order_url(@musicbrainz_import_order), params: {musicbrainz_import_order: {code: "95082032-de1f-11ed-b6f4-176c9096c629"}}

    assert_redirected_to musicbrainz_import_order_url(@musicbrainz_import_order)
  end

  test "should not update musicbrainz_import_order_with_bad_parameters" do
    patch musicbrainz_import_order_url(@musicbrainz_import_order), params: {musicbrainz_import_order: {code: "bad evil"}}

    assert_response :unprocessable_entity
  end

  test "should destroy musicbrainz_import_order" do
    assert_difference("MusicbrainzImportOrder.count", -1) do
      delete musicbrainz_import_order_url(@musicbrainz_import_order)
    end

    assert_redirected_to musicbrainz_import_orders_url
  end
end
