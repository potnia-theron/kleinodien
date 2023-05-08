require "test_helper"
require "shared_import_order_tests"

class MusicBrainzImportOrderTest < ActiveSupport::TestCase
  include SharedImportOrderTests

  def setup
    @subject = MusicBrainzImportOrder.new(kind: "release", code: "41362dd7-0665-4e09-8158-9ad8109d47bc", user: users(:kim))
  end

  def test_with_a_valid_uri
    import_order = MusicBrainzImportOrder.new(uri: "https://musicbrainz.org/release/41362dd7-0665-4e09-8158-9ad8109d47bc", user: users(:kim))

    assert_predicate import_order, :valid?
    assert_equal "release", import_order.kind
    assert_equal "41362dd7-0665-4e09-8158-9ad8109d47bc", import_order.code
  end

  def test_import_order_uri_type
    assert_nil @subject.uri

    @subject.uri = "https://musicbrainz.org/release/41362dd7-0665-4e09-8158-9ad8109d47bc"

    assert_kind_of ImportOrderUri::MusicBrainz, @subject.uri
  end

  def test_with_a_valid_uri_and_a_kind
    import_order = MusicBrainzImportOrder.new(kind: "release", uri: "https://musicbrainz.org/non/sense", user: users(:kim))

    assert_not_predicate import_order, :valid?
    assert_equal "release", import_order.kind
    assert_nil import_order.code
  end

  def test_with_a_valid_uri_and_code
    import_order = MusicBrainzImportOrder.new(code: "41362dd7-0665-4e09-8158-9ad8109d47bc", uri: "https://musicbrainz.org/non/sense", user: users(:kim))

    assert_not_predicate import_order, :valid?
    assert_nil import_order.kind
    assert_equal "41362dd7-0665-4e09-8158-9ad8109d47bc", import_order.code
  end
end
