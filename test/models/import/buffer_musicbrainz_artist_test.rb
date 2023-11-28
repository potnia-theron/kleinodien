require "test_helper"
require "support/web_mock_external_apis"

class Import::BufferMusicbrainzArtistTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup

    @from = Import::From.new(:fake_import_order)
    @buffer_fill = Import::BufferMusicbrainzArtist.new(@from)
  end

  test "#perform when artist does not exist" do
    assert_not @from.musicbrainz.buffered?(:artist, "66c662b6-6e2f-4930-8610-912e24c63ed1")

    @buffer_fill.perform("66c662b6-6e2f-4930-8610-912e24c63ed1")

    assert @from.musicbrainz.buffered?(:artist, "66c662b6-6e2f-4930-8610-912e24c63ed1")
  end

  test "#perform when artist already exists" do
    Participant.create!(name: "Lars Ulrich", musicbrainz_code: "dba976fe-8dd7-11ee-9658-c7d0bdbf1750")
    @buffer_fill.perform("dba976fe-8dd7-11ee-9658-c7d0bdbf1750")

    assert_not @from.musicbrainz.buffered?(:artist, "66c662b6-6e2f-4930-8610-912e24c63ed1")
  end
end
