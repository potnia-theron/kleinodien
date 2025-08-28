require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_registrations_path
    assert_response :success
    assert_select "form" # Ensure the form is rendered
  end

  test "should create user with valid params" do
    assert_difference("User.count", 1) do
      post registrations_path, params: {
        user: {
          email_address: "test@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end
    assert_redirected_to root_path
    assert_equal "You've successfully signed up to Kleinodien", flash[:notice]
  end

  test "should not create user with invalid params" do
    assert_no_difference("User.count") do
      post registrations_path, params: {
        user: {
          email_address: "invalid_email",
          password: "short",
          password_confirmation: "mismatch"
        }
      }
    end
    assert_response :unprocessable_content
    assert_match "Email address is invalid", flash[:alert]
    assert_match "Password is too short", flash[:alert]
    assert_match "Password confirmation doesn't match Password", flash[:alert]
  end
end
