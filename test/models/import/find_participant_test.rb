require "test_helper"
require "minitest/mock"
require "support/shared_import_find_tests"

class Import::FindParticipantTest < ActiveSupport::TestCase
  include SharedImportFindTests

  setup do
    @subject = Import::FindParticipant
  end
  test "foo" do
    assert true
  end

  #   test "find a non existent Participant" do
  #     properties = Minitest::Mock.new

  #     session = Minitest::Mock.new
  #     session.expect :build_properties, properties, [Participant]

  #     facade = Minitest::Mock.new
  #     facade.expect :intrinsic_codes, {discogs_code: "321"}
  #     2.times { facade.expect :model_class, Participant }
  #     facade.expect :all_codes, {discogs_code: "321", tmdb_code: "11"}

  #     finder = Import::FindParticipant.new(session, facade: facade)

  #     assert_not finder.call
  #   end
end
