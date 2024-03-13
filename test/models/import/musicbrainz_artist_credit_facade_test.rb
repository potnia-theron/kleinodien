require "test_helper"
require "minitest/mock"
require "support/shared_import_facade_tests"

class Import::MusicbrainzArtistCreditFacadeTest < ActiveSupport::TestCase
  include SharedImportFacadeTests
  TestParticipant = Data.define(:name, :joinphrase)

  setup do
    @data = Minitest::Mock.new
    @subject = Import::MusicbrainzParticipantFacade.new(:fake_session, {data: @data})
  end

  test "#name" do
    test_participants = [
      TestParticipant.new("Diana", " feat. "),
      TestParticipant.new("Artemis", nil)
    ]

    data = Minitest::Mock.new
    data.expect :map, test_participants

    facade = Import::MusicbrainzArtistCreditFacade.new(:fake_session, data: test_participants)

    assert_equal "Diana feat. Artemis", facade.name

    # TODO: How to verify if the expected metod gets a block?
    # data.verify
  end

  test "joinphrase in last name" do
    test_participants = [
      TestParticipant.new("Artemis", nil),
      TestParticipant.new("Diana", " feat. ")
    ]

    data = Minitest::Mock.new
    data.expect :map, test_participants

    facade = Import::MusicbrainzArtistCreditFacade.new(:fake_session, data: test_participants)

    assert_raises(RuntimeError) { facade.name }
    # TODO: How to verify if the expected metod gets a block?
    # data.verify
  end
end
