require "test_helper"

class ImportOrderUriTypeTest < ActiveSupport::TestCase
  extend ActiveSupport::Testing::Declarative

  setup do
    @type_iou = ImportOrderUriType.new
  end

  test "cast musicbrainz uri" do
    uri_string = "https://musicbrainz.org/release/bc5fe528-ab8e-4ca2-9f4f-e362a3d24255"

    iou = @type_iou.cast(uri_string)

    assert_kind_of ImportOrderUri::Common, iou
    assert_kind_of ImportOrderUri::Musicbrainz, iou
  end

  test "serialize something that is not blank" do
    serialized = @type_iou.serialize(:hello)

    assert_equal "hello", serialized
  end

  test "serialize something that is blank" do
    assert_nil @type_iou.serialize("")
    assert_nil @type_iou.serialize("   ")
    assert_nil @type_iou.serialize(nil)
  end
end
