require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:kim)
    # @user.update(password_reset_token: "valid_token")
    @user.update(password: "not_save", password_confirmation: "not_save")
  end

  test "should get new" do
    get new_password_path
    assert_response :success
  end

  test "should create password reset and send email" do
    assert_enqueued_emails 1 do
      post passwords_path, params: {email_address: @user.email_address}
    end
    assert_redirected_to new_session_path
    assert_equal "Password reset instructions sent (if user with that email address exists).", flash[:notice]
  end

  test "should not send email if user does not exist" do
    assert_no_enqueued_emails do
      post passwords_path, params: {email_address: "nonexistent@example.com"}
    end
    assert_redirected_to new_session_path
    assert_equal "Password reset instructions sent (if user with that email address exists).", flash[:notice]
  end

  test "should get edit with valid token" do
    get edit_password_path(token: @user.password_reset_token)
    assert_response :success
  end

  test "should redirect to new password path with invalid token" do
    get edit_password_path(token: "invalid_token")
    assert_redirected_to new_password_path
    assert_equal "Password reset link is invalid or has expired.", flash[:alert]
  end

  test "should update password with valid token" do
    patch password_path(token: @user.password_reset_token), params: {password: "newpassword", password_confirmation: "newpassword"}
    assert_redirected_to new_session_path
    assert_equal "Password has been reset.", flash[:notice]
    assert @user.reload.authenticate("newpassword")
  end

  test "should not update password if confirmation does not match" do
    token = @user.password_reset_token
    patch password_path(token: token, params: {password: "newpassword", password_confirmation: "wrongconfirmation"})

    assert_redirected_to edit_password_path(token: token)
    assert_equal "Passwords did not match.", flash[:alert]
  end
end
