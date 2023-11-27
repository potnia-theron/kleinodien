require "test_helper"
require "support/web_mock_external_apis"

class Import::BufferAParticipantFromMusicBrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup

    @from = Import::From.new(:fake_import_order)
  end

  test "participant gets buffered" do
    # TODO: test with real data
    assert_equal @from.musicbrainz.get(:artist, "66c662b6-6e2f-4930-8610-912e24c63ed1"), :foo
  end
end
