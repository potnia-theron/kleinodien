require "test_helper"

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get main_url
    assert_response :success
  end
end
