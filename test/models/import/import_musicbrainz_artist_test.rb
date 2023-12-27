require "test_helper"
require "support/web_mock_external_apis"

class Import::ImportMusicbrainzArtistTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup

    # @from = Import::From.new(:fake_import_order)
    # @buffer_fill = Import::BufferMusicbrainzArtist.new(@from)
    factory = Import::MusicbrainzFactory.new(:fake_import_order)
    @intermediate = factory.build_intermediate(Participant, "66c662b6-6e2f-4930-8610-912e24c63ed1")
  end

  test "Import AC/DC" do
    assert_difference("Participant.count", 1) do
      @intermediate.prepare!
      @intermediate.save!
    end
  end
end
