require "test_helper"
require "minitest/mock"
require "support/shared_import_facade_tests"

class Import::MusicbrainzArtistCreditFacadeTest < ActiveSupport::TestCase
  include SharedImportFacadeTests

  TestParticipant = Data.define(:name, :joinphrase)
  TestDiana = TestParticipant.new("Diana", " feat. ")
  TestArtemis = TestParticipant.new("Artemis", nil)

  setup do
    @data = []
    @subject = Import::MusicbrainzArtistCreditFacade.new(:fake_session, data: @data)
  end

  test "#name with valid data" do
    @data.push(TestDiana, TestArtemis)

    assert_equal "Diana feat. Artemis", @subject.name
  end

  test "joinphrase in last name" do
    @data.push(TestArtemis, TestDiana)

    assert_raises(RuntimeError) { @subject.name }
  end
end
