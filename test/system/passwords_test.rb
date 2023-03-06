require "application_system_test_case"

class PasswordsTest < ApplicationSystemTestCase
  setup do
    @user = sign_in_as(users(:kim))
  end

  test "updating the password" do
    click_on "Change password"

    fill_in "Current password", with: "Secret1*3*5*"
    fill_in "New password", with: "TopSecret"
    fill_in "Confirm new password", with: "TopSecret"
    click_on "Save changes"

    assert_text "Your password has been changed"
  end
end
