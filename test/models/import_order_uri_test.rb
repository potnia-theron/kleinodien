require "test_helper"

class ImportOrderUriTest < ActiveSupport::TestCase
  def test_with_some_uri_string
    uri_string = "https://example.com/nothing/here"
    iou = ImportOrderUri.build(uri_string)

    assert_kind_of ImportOrderUri::Common, iou
  end

  def test_with_a_musicbrainz_uri_string
    uri_string = "https://musicbrainz.org/release/23cbaa49-1e24-4550-88c9-d07de78b5b89"

    iou = ImportOrderUri.build(uri_string)

    assert_kind_of ImportOrderUri::MusicBrainz, iou
    assert_equal "23cbaa49-1e24-4550-88c9-d07de78b5b89", iou.code
    assert_equal "release", iou.kind
  end

  def test_common
    iou = OpenStruct.new(path: "/foo/bar")

    iou.extend ImportOrderUri::Common

    assert_nil iou.code
    assert_nil iou.kind
  end

  def test_musicbrainz_with_a_valid_path
    iou = OpenStruct.new(path: "/release/23cbaa49-1e24-4550-88c9-d07de78b5b89")

    iou.extend ImportOrderUri::MusicBrainz

    assert_equal "23cbaa49-1e24-4550-88c9-d07de78b5b89", iou.code
    assert_equal "release", iou.kind
  end

  def test_musicbrainz_with_an_invalid_path
    iou = OpenStruct.new(path: "/wrong/not-a-uuid")
    iou.extend ImportOrderUri::MusicBrainz

    assert_nil iou.code
    assert_nil iou.kind
  end
end
