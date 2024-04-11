require "test_helper"
require "minitest/mock"
require "support/shared_import_find_tests"

class Import::FindArtistCreditTest < ActiveSupport::TestCase
  include SharedImportFindTests

  setup do
    @facade = Minitest::Mock.new
    @subject = Import::FindArtistCredit.new(:fake_session, facade: @facade)
  end

  test "ArtistCredit can't be found" do
    @facade.expect :name, "Reborn Christians"

    assert_not @subject.call
  end

  test "find ArtistCredit by name" do
    ArtistCredit.create!(name: "Suicide Angels")
    @facade.expect :name, "Suicide Angels"

    assert_equal "Suicide Angels", @subject.call.name
  end
end
