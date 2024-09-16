require "test_helper"
require "support/retrieve"

class Import::MusicbrainzRelationsCodeTest < ActiveSupport::TestCase
  test "AC/DC" do
    json_string = Retrieve.musicbrainz(:artist, "66c662b6-6e2f-4930-8610-912e24c63ed1")
    relations = Import::Json.parse(json_string)[:relations]
    codes = Import::MusicbrainzRelationsCode.extract(relations)

    assert_equal codes.dig(:discogs, :artist), "84752"
    assert_equal codes.dig(:imdb, :name), "nm0009540"
  end

  test "with generic data" do
    relations = [
      # shoud be used:
      {target_type: "url", type: "discogs", url: {resource: "https://discogs.com/release/5432"}},
      {target_type: "url", type: "discogs", url: {resource: "https://discogs.com/artist/123"}},
      {target_type: "url", type: "IMDb", url: {resource: "https://imdb.com/name/nm123"}},

      # should be ignored:
      {target_type: "somathing"},
      {target_type: "url", type: "example", url: {resource: "http://example.com/gizmo/gremlin"}},
      # bad:
      {target_type: "url", type: "discogs", url: {resource: "NOT AN URI!"}},
      {target_type: "url", type: "discogs", url: {resource: "http://example.com/gizmo/gremlin"}}
    ]

    codes = Import::MusicbrainzRelationsCode.extract(relations)

    assert_equal codes, {
      discogs: {artist: "123", release: "5432"},
      imdb: {name: "nm123"}
    }
  end
end
