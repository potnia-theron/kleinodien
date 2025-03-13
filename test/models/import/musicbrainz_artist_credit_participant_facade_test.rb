require "test_helper"

class Import::MusicbrainzArtistCreditParticipantFacadeTest < ActiveSupport::TestCase
  test "scrape values" do
    participant_code = "42cb140a-510d-4f8a-8246-94c2eb05df0a"

    options = {
      joinphrase: " feat. ",
      artist: {id: participant_code},
      position: 0
    }

    facade = Import::MusicbrainzArtistCreditParticipantFacade.new(:fake, options)

    assert_equal " feat. ", facade.scrape(:join_phrase)
    assert_equal({musicbrainz_code: participant_code}, facade.scrape(:participant))
    assert_equal 0, facade.scrape(:position)
  end
end
