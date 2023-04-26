require "test_helper"

class TypeImportOrderUriTest < ActiveSupport::TestCase
  def test_that_it_returns_an_import_order_uri_common_object
    iou = TypeImportOrderUri.new.cast("https://example.com/nothing/here")

    assert_kind_of ImportOrderUri::Common, iou
  end

  def test_that_it_returns_an_import_order_uri_musicbrainz_object
    iou = TypeImportOrderUri.new.cast("https://musicbrainz.org/some-kind/27c7483a-e456-11ed-b135-2b11f43836eb")

    assert_kind_of ImportOrderUri::Common, iou
    assert_kind_of ImportOrderUri::MusicBrainz, iou
  end
end
