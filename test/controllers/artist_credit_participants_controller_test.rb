require "test_helper"

class ArtistCreditParticipantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artist_credit_participant = artist_credit_participants(:one)
    @user = sign_in_as(users(:kim))
  end

  test "should get index" do
    get artist_credit_participants_url

    assert_response :success
  end

  test "should get new" do
    get new_artist_credit_participant_url

    assert_response :success
  end

  test "should create artist_credit_participant" do
    position = @artist_credit_participant.position.next

    assert_difference("ArtistCreditParticipant.count") do
      post artist_credit_participants_url, params: {artist_credit_participant: {artist_credit_id: @artist_credit_participant.artist_credit_id, join_phrase: @artist_credit_participant.join_phrase, participant_id: @artist_credit_participant.participant_id, position: position}}
    end

    assert_redirected_to artist_credit_participant_url(ArtistCreditParticipant.last)
  end

  test "should show artist_credit_participant" do
    get artist_credit_participant_url(@artist_credit_participant)

    assert_response :success
  end

  test "should get edit" do
    get edit_artist_credit_participant_url(@artist_credit_participant)

    assert_response :success
  end

  test "should update artist_credit_participant" do
    patch artist_credit_participant_url(@artist_credit_participant), params: {artist_credit_participant: {artist_credit_id: @artist_credit_participant.artist_credit_id, join_phrase: @artist_credit_participant.join_phrase, participant_id: @artist_credit_participant.participant_id, position: @artist_credit_participant.position}}

    assert_redirected_to artist_credit_participant_url(@artist_credit_participant)
  end

  test "should destroy artist_credit_participant" do
    assert_difference("ArtistCreditParticipant.count", -1) do
      delete artist_credit_participant_url(@artist_credit_participant)
    end

    assert_redirected_to artist_credit_participants_url
  end
end
