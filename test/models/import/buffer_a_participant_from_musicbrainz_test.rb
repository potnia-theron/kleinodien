require "test_helper"
require "support/web_mock_external_apis"

class Import::BufferAParticipantFromMusicBrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup

    @api = Import::MusicbrainzApi.new
    @handler = Import::FromHandler.new(@api)
  end

  test "participant gets buffered" do
    @handler.fetch(:artist, "66c662b6-6e2f-4930-8610-912e24c63ed1") { :expected }
    assert_equal @handler.get(:artist, "66c662b6-6e2f-4930-8610-912e24c63ed1"), :expected
  end
end
