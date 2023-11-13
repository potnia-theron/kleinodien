require "test_helper"

class ArtistCreditsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artist_credit = artist_credits(:one)
    @user = sign_in_as(users(:kim))
  end

  test "should get index" do
    get artist_credits_url

    assert_response :success
  end

  test "should get new" do
    get new_artist_credit_url

    assert_response :success
  end

  test "should create artist_credit" do
    assert_difference("ArtistCredit.count") do
      post artist_credits_url, params: {artist_credit: {name: @artist_credit.name}}
    end

    assert_redirected_to artist_credit_url(ArtistCredit.last)
  end

  test "should show artist_credit" do
    get artist_credit_url(@artist_credit)

    assert_response :success
  end

  test "should get edit" do
    get edit_artist_credit_url(@artist_credit)

    assert_response :success
  end

  test "should update artist_credit" do
    patch artist_credit_url(@artist_credit), params: {artist_credit: {name: @artist_credit.name}}

    assert_redirected_to artist_credit_url(@artist_credit)
  end

  test "should destroy artist_credit" do
    assert_difference("ArtistCredit.count", -1) do
      delete artist_credit_url(@artist_credit)
    end

    assert_redirected_to artist_credits_url
  end
end
