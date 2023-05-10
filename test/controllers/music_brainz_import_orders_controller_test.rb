require "test_helper"

class MusicBrainzImportOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @music_brainz_import_order = music_brainz_import_orders(:music_brainz_one)
    @user = sign_in_as(users(:kim))
  end

  test "should get index" do
    get music_brainz_import_orders_url

    assert_response :success
  end

  test "should get new" do
    get new_music_brainz_import_order_url

    assert_response :success
  end

  test "should create music_brainz_import_order" do
    assert_difference("MusicBrainzImportOrder.count") do
      post music_brainz_import_orders_url, params: {music_brainz_import_order: {code: @music_brainz_import_order.code, kind: @music_brainz_import_order.kind, user_id: @music_brainz_import_order.user_id}}
    end

    assert_redirected_to music_brainz_import_order_url(MusicBrainzImportOrder.last)
  end

  test "should not create music_brainz_import_order with bad parameters" do
    assert_no_difference("MusicBrainzImportOrder.count") do
      post music_brainz_import_orders_url, params: {music_brainz_import_order: {bad: "evil"}}
    end

    assert_response :unprocessable_entity
  end

  test "should show music_brainz_import_order" do
    get music_brainz_import_order_url(@music_brainz_import_order)

    assert_response :success
  end

  test "should get edit" do
    get edit_music_brainz_import_order_url(@music_brainz_import_order)

    assert_response :success
  end

  test "should update music_brainz_import_order" do
    patch music_brainz_import_order_url(@music_brainz_import_order), params: {music_brainz_import_order: {code: "95082032-de1f-11ed-b6f4-176c9096c629"}}

    assert_redirected_to music_brainz_import_order_url(@music_brainz_import_order)
  end

  test "should destroy music_brainz_import_order" do
    assert_difference("MusicBrainzImportOrder.count", -1) do
      delete music_brainz_import_order_url(@music_brainz_import_order)
    end

    assert_redirected_to music_brainz_import_orders_url
  end
end
