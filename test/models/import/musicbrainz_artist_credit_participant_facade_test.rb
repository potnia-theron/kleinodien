require "test_helper"
# require "minitest/mock"
require "support/retrieve"
require "support/retrieve/musicbrainz"

class Import::MusicbrainzArtistCreditParticipantFacadeTest < ActiveSupport::TestCase
  test "foo" do
    participant_code = "42cb140a-510d-4f8a-8246-94c2eb05df0a"

    options = {
      joinphrase: " feat. ",
      artist: {id: participant_code},
      position: 0
    }

    facade = Import::MusicbrainzArtistCreditParticipantFacade.new(:foo, options)

    assert_equal " feat. ", facade.scrape(:join_phrase)
    assert_equal({musicbrainz_code: participant_code}, facade.scrape(:participant))
    assert_equal 0, facade.scrape(:position)
  end
end
