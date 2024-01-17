require "test_helper"
require "support/retrieve"

class Import::MusicbrainzRelationsCodeTest < ActiveSupport::TestCase
  setup do
    json_string = Retrieve.musicbrainz(:artist, "66c662b6-6e2f-4930-8610-912e24c63ed1")
    @relations = Import::Json.parse(json_string).relations
  end

  test "foobar" do
    codes = Import::MusicbrainzRelationsCode.extract(@relations)

    assert_equal codes["discogs.com"]["artist"], "84752"
    assert_equal codes["imdb.com"]["name"], "nm0009540"
  end
end
