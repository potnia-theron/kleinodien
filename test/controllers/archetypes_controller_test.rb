require "test_helper"

class ArchetypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @archetype = archetypes(:one)
    @user = sign_in_as(users(:kim))
  end

  test "should get index" do
    get archetypes_url
    assert_response :success
  end

  test "should get new" do
    get new_archetype_url
    assert_response :success
  end

  test "should create archetype" do
    assert_difference("Archetype.count") do
      # post archetypes_url, params: {archetype: {archetypeable_type: @archetype.archetypeable_type, artist_credit_id: @archetype.artist_credit_id, title: @archetype.title}}
      post archetypes_url, params: {archetype: {archetypeable_id: @archetype.archetypeable_id, archetypeable_type: @archetype.archetypeable_type, title: @archetype.title}}
      # post archetypes_url, params: {archetype: {archetypeable_type: @archetype.archetypeable_type, title: @archetype.title}}
    end

    assert_redirected_to archetype_url(Archetype.last)
  end

  test "should show archetype" do
    get archetype_url(@archetype)
    assert_response :success
  end

  test "should get edit" do
    get edit_archetype_url(@archetype)
    assert_response :success
  end

  test "should update archetype" do
    # patch archetype_url(@archetype), params: {archetype: {archetypeable_id: @archetype.archetypeable_id, archetypeable_type: @archetype.archetypeable_type, artist_credit_id: @archetype.artist_credit_id, title: @archetype.title}}
    patch archetype_url(@archetype), params: {archetype: {archetypeable_id: @archetype.archetypeable_id, archetypeable_type: @archetype.archetypeable_type, title: @archetype.title}}
    assert_redirected_to archetype_url(@archetype)
  end

  test "should destroy archetype" do
    assert_difference("Archetype.count", -1) do
      delete archetype_url(@archetype)
    end

    assert_redirected_to archetypes_url
  end
end
