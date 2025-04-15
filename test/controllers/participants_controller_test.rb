require "test_helper"

class ParticipantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @participant = participants(:one)
    @user = sign_in_as(users(:kim))
  end

  test "should get index" do
    get participants_url

    assert_response :success
  end

  test "should get new" do
    get new_participant_url

    assert_response :success
  end

  test "should create participant" do
    assert_difference("Participant.count") do
      post participants_url, params: {participant: {name: "Rock star", sort_name: "Rock star"}}
    end

    assert_redirected_to participant_url(Participant.last)
  end

  test "should show participant" do
    get participant_url(@participant)

    assert_response :success
  end

  test "should get edit" do
    get edit_participant_url(@participant)

    assert_response :success
  end

  test "should update participant" do
    patch participant_url(@participant), params: {participant: {begin_date: @participant.begin_date, begin_date_accuracy: @participant.begin_date_accuracy, disambiguation: @participant.disambiguation, discogs_code: @participant.discogs_code, end_date: @participant.end_date, end_date_accuracy: @participant.end_date_accuracy, imdb_code: @participant.imdb_code, import_order_id: @participant.import_order_id, musicbrainz_code: @participant.musicbrainz_code, name: "Rock star", sort_name: @participant.sort_name, tmdb_code: @participant.tmdb_code, wikidata_code: @participant.wikidata_code}}

    assert_redirected_to participant_url(@participant)
  end

  # Test fails since Participant is "centralable"
  # test "should destroy participant" do
  #   assert_difference("Participant.count", -1) do
  #     delete participant_url(@participant)
  #   end

  #   assert_redirected_to participants_url
  # end
end
