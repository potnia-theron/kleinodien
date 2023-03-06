require "application_system_test_case"

class RegistrationsTest < ApplicationSystemTestCase
  test "signing up" do
    visit sign_up_url

    fill_in "Email", with: "kim@example.com"
    fill_in "Password", with: "TopSecret"
    fill_in "Password confirmation", with: "TopSecret"
    click_on "Sign up"

    assert_text "Welcome! You have signed up successfully"
  end
end
