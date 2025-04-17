require "test_helper"

class ImportOrderUriTest < ActiveSupport::TestCase
  extend ActiveSupport::Testing::Declarative

  test "common" do
    iou = ImportOrderUri.build("https://example.com/some/stuff")

    assert_equal "ImportOrder", iou.import_order_type
    assert_kind_of ImportOrderUri::Common, iou
  end

  test "common kind and code" do
    iou = ImportOrderUri.build("https://example.com/some/stuff")

    assert_nil iou.code
    assert_nil iou.kind
  end

  test "musicbrainz with a valid path" do
    iou = ImportOrderUri.build("https://musicbrainz.org/release/23cbaa49-1e24-4550-88c9-d07de78b5b89")

    assert_equal "MusicbrainzImportOrder", iou.import_order_type
    assert_kind_of ImportOrderUri::Musicbrainz, iou
  end

  test "musicbrainz kind and kode with a valid path" do
    iou = ImportOrderUri.build("https://musicbrainz.org/release/23cbaa49-1e24-4550-88c9-d07de78b5b89")

    assert_equal "23cbaa49-1e24-4550-88c9-d07de78b5b89", iou.code
    assert_equal "release", iou.kind
  end

  test "musicbrainz with an invalid path" do
    iou = ImportOrderUri.build("https://musicbrainz.org/this/is/not-an-uuid")

    assert_kind_of ImportOrderUri::Musicbrainz, iou
    assert_nil iou.code
    assert_nil iou.kind
  end
end
