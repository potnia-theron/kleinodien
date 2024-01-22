require "test_helper"
require "support/retrieve"

class Import::MusicbrainzRelationsCodeTest < ActiveSupport::TestCase
  test "AC/DC" do
    codes = Import::MusicbrainzRelationsCode.extract(acdc_relations)

    assert_equal codes["discogs"]["artist"], "84752"
    assert_equal codes["imdb"]["name"], "nm0009540"
  end

  test "with generic data" do
    relations = [
      # shoud be used:
      url_rel_for("url", "discogs", "https://discogs.com/release/5432"),
      url_rel_for("url", "discogs", "https://discogs.com/artist/123"),
      url_rel_for("url", "IMDb", "https://imdb.com/name/nm123"),
      # should be ignored:
      url_rel_for("someting"),
      url_rel_for("url", "example", "http://example.com/gizmo/gremlin"),
      # bad:
      url_rel_for("url", "discogs", "NOT AN URI!"),
      url_rel_for("url", "discogs", "http://example.com/gizmo/gremlin"),
      OpenStruct.new(target_type: "url", type: "IMDb")
    ]

    codes = Import::MusicbrainzRelationsCode.extract(relations)

    assert_equal codes, {
      "discogs" => {"artist" => "123", "release" => "5432"},
      "imdb" => {"name" => "nm123"}
    }
  end

  # helper methods
  def acdc_relations
    json_string = Retrieve.musicbrainz(:artist, "66c662b6-6e2f-4930-8610-912e24c63ed1")
    Import::Json.parse(json_string).relations
  end

  def url_rel_for(target_type = nil, type = nil, url = nil)
    OpenStruct.new(
      target_type: target_type,
      type: type,
      url: OpenStruct.new(resource: url)
    )
  end
end
