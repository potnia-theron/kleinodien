require "test_helper"

class EditionSectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @edition_section = edition_sections(:one)
    # @user = sign_in_as(users(:kim))
  end

  test "should get index" do
    get edition_sections_url
    assert_response :success
  end

  test "should get new" do
    get new_edition_section_url
    assert_response :success
  end

  test "should create edition_section" do
    assert_difference("EditionSection.count") do
      post edition_sections_url, params: {edition_section: {alphanumeric: @edition_section.alphanumeric, edition_id: @edition_section.edition_id, level: @edition_section.level, no: @edition_section.no, positions_count: @edition_section.positions_count}}
    end

    assert_redirected_to edition_section_url(EditionSection.last)
  end

  test "should show edition_section" do
    get edition_section_url(@edition_section)
    assert_response :success
  end

  test "should get edit" do
    get edit_edition_section_url(@edition_section)
    assert_response :success
  end

  test "should update edition_section" do
    patch edition_section_url(@edition_section), params: {edition_section: {alphanumeric: @edition_section.alphanumeric, edition_id: @edition_section.edition_id, level: @edition_section.level, no: @edition_section.no, positions_count: @edition_section.positions_count}}
    assert_redirected_to edition_section_url(@edition_section)
  end

  # test "should destroy edition_section" do
  #   assert_difference("EditionSection.count", -1) do
  #     delete edition_section_url(@edition_section)
  #   end

  #   assert_redirected_to edition_sections_url
  # end
end
