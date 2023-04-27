require "test_helper"

class ImportOrderUriTest < ActiveSupport::TestCase
  def test_common
    iou = ImportOrderUri.build("https://example.com/some/stuff")

    assert_kind_of ImportOrderUri::Common, iou
    assert_nil iou.code
    assert_nil iou.kind
  end

  def test_musicbrainz_with_a_valid_path
    iou = ImportOrderUri.build("https://musicbrainz.org/release/23cbaa49-1e24-4550-88c9-d07de78b5b89")

    assert_kind_of ImportOrderUri::MusicBrainz, iou
    assert_equal "23cbaa49-1e24-4550-88c9-d07de78b5b89", iou.code
    assert_equal "release", iou.kind
  end

  def test_musicbrainz_with_an_invalid_path
    iou = ImportOrderUri.build("https://musicbrainz.org/this/is/not-an-uuid")

    assert_kind_of ImportOrderUri::MusicBrainz, iou
    assert_nil iou.code
    assert_nil iou.kind
  end
end
