require "test_helper"

class LinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @link = links(:one)
    @user = sign_in_as(users(:sam))
  end

  test "should get index" do
    get links_url
    assert_response :success
  end

  test "should get new" do
    get new_link_url
    assert_response :success
  end

  test "should create link" do
    assert_difference("Link.count") do
      post links_url, params: {link: {begin_data: @link.begin_data, begin_date_accuracy: @link.begin_date_accuracy, destination_id: @link.destination_id, end_date: @link.end_date, end_date_accuracy: @link.end_date_accuracy, link_kind_id: @link.link_kind_id, source_id: @link.source_id}}
    end

    assert_redirected_to link_url(Link.last)
  end

  test "should show link" do
    get link_url(@link)
    assert_response :success
  end

  test "should get edit" do
    get edit_link_url(@link)
    assert_response :success
  end

  test "should update link" do
    patch link_url(@link), params: {link: {begin_data: @link.begin_data, begin_date_accuracy: @link.begin_date_accuracy, destination_id: @link.destination_id, end_date: @link.end_date, end_date_accuracy: @link.end_date_accuracy, link_kind_id: @link.link_kind_id, source_id: @link.source_id}}
    assert_redirected_to link_url(@link)
  end

  test "should destroy link" do
    assert_difference("Link.count", -1) do
      delete link_url(@link)
    end

    assert_redirected_to links_url
  end
end
