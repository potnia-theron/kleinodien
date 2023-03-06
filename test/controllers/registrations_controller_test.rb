require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get sign_up_url
    assert_response :success
  end

  test "should sign up" do
    assert_difference("User.count") do
      post sign_up_url, params: {email: "other@example.com", password: "123TopSecret", password_confirmation: "123TopSecret"}
    end

    assert_redirected_to root_url
  end
end
