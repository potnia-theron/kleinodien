require "test_helper"

class LinkKindsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @link_kind = link_kinds(:one)
    # @user = sign_in_as(users(:kim))
  end

  test "should get index" do
    get link_kinds_url
    assert_response :success
  end

  test "should get new" do
    get new_link_kind_url
    assert_response :success
  end

  test "should create link_kind" do
    assert_difference("LinkKind.count") do
      post link_kinds_url, params: {link_kind: {description: @link_kind.description, link_phrase: @link_kind.link_phrase, long_link_phrase: @link_kind.long_link_phrase, musicbrainz_code: @link_kind.musicbrainz_code, name: "yet another link kind", reverse_link_phrase: @link_kind.reverse_link_phrase}}
    end

    assert_redirected_to link_kind_url(LinkKind.last)
  end

  test "should show link_kind" do
    get link_kind_url(@link_kind)
    assert_response :success
  end

  test "should get edit" do
    get edit_link_kind_url(@link_kind)
    assert_response :success
  end

  test "should update link_kind" do
    patch link_kind_url(@link_kind), params: {link_kind: {description: @link_kind.description, link_phrase: @link_kind.link_phrase, long_link_phrase: @link_kind.long_link_phrase, musicbrainz_code: @link_kind.musicbrainz_code, name: "my new name", reverse_link_phrase: @link_kind.reverse_link_phrase}}
    assert_redirected_to link_kind_url(@link_kind)
  end

  test "should destroy link_kind" do
    destroyable_kind = link_kinds(:destroyable)
    assert_difference("LinkKind.count", -1) do
      delete link_kind_url(destroyable_kind)
    end

    assert_redirected_to link_kinds_url
  end
end
