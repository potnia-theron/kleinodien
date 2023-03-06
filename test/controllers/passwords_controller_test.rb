require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in_as(users(:kim))
  end

  test "should get edit" do
    get edit_password_url
    assert_response :success
  end

  test "should update password" do
    patch password_url, params: {current_password: "123TopSecret", password: "TopSecret123", password_confirmation: "TopSecret123"}
    assert_redirected_to root_url
  end

  test "should not update password with wrong current password" do
    patch password_url, params: {current_password: "SecretWrong1*3", password: "TopSecret", password_confirmation: "TopSecret"}

    assert_redirected_to edit_password_url
    assert_equal "The current password you entered is incorrect", flash[:alert]
  end
end
