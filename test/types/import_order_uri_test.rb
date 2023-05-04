require "test_helper"

class ImportOrderUriTest < ActiveSupport::TestCase
  def setup
    @type_iou = ActiveRecord::Type::ImportOrderUri.new
  end

  def test_cast_musicbrainz_uri
    uri_string = "https://musicbrainz.org/release/bc5fe528-ab8e-4ca2-9f4f-e362a3d24255"

    iou = @type_iou.cast(uri_string)

    assert_kind_of ImportOrderUri::Common, iou
    assert_kind_of ImportOrderUri::MusicBrainz, iou
  end

  def test_serialize_something_that_is_not_blank
    serialized = @type_iou.serialize(:hello)

    assert_equal "hello", serialized
  end

  def test_serialize_something_that_is_blank
    assert_nil @type_iou.serialize("")
    assert_nil @type_iou.serialize("   ")
    assert_nil @type_iou.serialize(nil)
  end
end
