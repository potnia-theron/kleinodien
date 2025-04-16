require "test_helper"

class CreateMusicBrainzImportOrderTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in_as(users(:kim))
  end

  test "can create a MusicbrainzImportOrder" do
    get new_import_order_path

    assert_response :success

    post "/import_orders", params: {import_order: {code: "c0f4b036-e215-43f7-970d-9506e053ea82", kind: "release", state: "open", type: "MusicbrainzImportOrder"}} # , user_id: @user.id}}

    assert_response :redirect
    follow_redirect!

    assert_response :success
    assert_select "p", "Import order was successfully created."
  end
end
