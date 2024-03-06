require "test_helper"
require "support/web_mock_external_apis"

class Import::ImportAnFromParticipantFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup

    @session = Import::Session.new(:fake_import_order, default_factory: :musicbrainz)

    @participant = @session
      .musicbrainz
      .get(:artist, "66c662b6-6e2f-4930-8610-912e24c63ed1")
    @facade = @session.build_facade(data: @participant, model: Participant)

    @handler = Import::Handler.new(@facade)
  end

  test "import an ArtistCredit" do
    persisted = @handler.call

    assert_equal persisted.name, "AC/DC"
  end
end
