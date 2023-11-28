require "test_helper"
require "support/web_mock_external_apis"

class Import::MusicbrainzAdapterTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup

    @from = Import::From.new(:fake_import_order)
    @adapter = Import::MusicbrainzAdapter.new(@from)
  end

  test "#participants" do
    @from.musicbrainz.get(:artist, "66c662b6-6e2f-4930-8610-912e24c63ed1")

    assert_equal @adapter.participants.length, 1

    first_participant = @adapter.participants.first
    assert_predicate Participant.new(first_participant), :valid?
  end
end
