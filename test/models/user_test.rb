require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid with valid attributes" do
    user = User.new(email_address: "vic@example.com", password: "password")
    assert user.valid?, "User is not valid with valid attributes"
  end

  test "is not valid without an email_address" do
    user = User.new(email_address: nil, password: "password")
    assert_not user.valid?, "User is valid without an email_address"
  end

  test "is not valid with a invalid email_address" do
    user = User.new(email_address: "bad-evil", password: "password")
    assert_not user.valid?, "User is valid with an invalid email_address"
  end

  test "is not valid without a password" do
    user = User.new(email_address: "vic@example.com", password: nil)
    assert_not user.valid?, "User is valid without a password"
  end

  test "password must be at least 6 characters" do
    user = User.new(email_address: "vic@example.com", password: "12345")
    assert_not user.valid?, "User is valid with a password less than 6 characters"

    user.password = "123456"
    assert user.valid?, "User is not valid with a password of 6 characters"
  end
end
