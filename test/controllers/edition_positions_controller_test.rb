require "test_helper"

class EditionPositionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @edition_position = edition_positions(:one)
    @user = sign_in_as(users(:sam))
  end

  test "should get index" do
    get edition_positions_url
    assert_response :success
  end

  test "should get new" do
    get new_edition_position_url
    assert_response :success
  end

  test "should create edition_position" do
    assert_difference("EditionPosition.count") do
      post edition_positions_url, params: {edition_position: {alphanumeric: @edition_position.alphanumeric, edition_id: @edition_position.edition_id, edition_section_id: @edition_position.edition_section_id, no: @edition_position.no}}
    end

    assert_redirected_to edition_position_url(EditionPosition.last)
  end

  test "should show edition_position" do
    get edition_position_url(@edition_position)
    assert_response :success
  end

  test "should get edit" do
    get edit_edition_position_url(@edition_position)
    assert_response :success
  end

  test "should update edition_position" do
    patch edition_position_url(@edition_position), params: {edition_position: {alphanumeric: @edition_position.alphanumeric, edition_id: @edition_position.edition_id, edition_section_id: @edition_position.edition_section_id, no: @edition_position.no}}
    assert_redirected_to edition_position_url(@edition_position)
  end

  test "should destroy edition_position" do
    assert_difference("EditionPosition.count", -1) do
      delete edition_position_url(@edition_position)
    end

    assert_redirected_to edition_positions_url
  end
end
