require "test_helper"
require "minitest/mock"

class MusicbrainzFacade::ArtistCreditParticipantTest < ActiveSupport::TestCase
  test "scrape values" do
    participant_code = "42cb140a-510d-4f8a-8246-94c2eb05df0a"

    factory = Minitest::Mock.new
    options = {
      joinphrase: " feat. ",
      artist: {id: participant_code},
      position: 0
    }

    factory.expect(:create, :fake_participant, [:participant, {musicbrainz_code: participant_code}])
    facade = MusicbrainzFacade::ArtistCreditParticipant.new(factory, options)

    assert_equal " feat. ", facade.scrape(:join_phrase)
    assert_equal(:fake_participant, facade.scrape(:participant))

    assert_equal 0, facade.scrape(:position)

    factory.verify
  end
end
