require "application_system_test_case"

class PasswordsTest < ApplicationSystemTestCase
  setup do
    @user = sign_in_as(users(:kim))
  end

  test "updating the password" do
    click_on "Change password"

    fill_in "Current password", with: "123TopSecret"
    fill_in "New password", with: "AnotherSecret456"
    fill_in "Confirm new password", with: "AnotherSecret456"
    click_on "Save changes"

    assert_text "Your password has been changed"
  end
end
