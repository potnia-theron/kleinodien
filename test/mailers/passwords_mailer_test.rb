require "test_helper"

class PasswordsMailerTest < ActionMailer::TestCase
  setup do
    @user = users(:kim)
  end

  test "password_reset" do
    mail = PasswordsMailer.reset(@user)

    assert_equal "Reset your password", mail.subject
    assert_equal [@user.email_address], mail.to
  end
end
