require "test_helper"
require "minitest/mock"

require "support/shared_bufferable_import_order_tests"
require "support/shared_import_order_tests"
require "support/shared_transitionable_tests"

class MusicbrainzImportOrderTest < ActiveSupport::TestCase
  include SharedBufferableImportOrderTests
  include SharedImportOrderTests
  include SharedTransitionableTests

  def setup
    @code = "66650826-7a63-11ef-9b55-871e6cdac01d"
    @uri = "https://musicbrainz.org/ws/2/release/#{@code}"
    @user = users(:kim)
    @subject = MusicbrainzImportOrder.new(kind: "release", code: @code, user: @user)
  end

  def test_with_a_valid_uri
    import_order = MusicbrainzImportOrder.new(uri: @uri, user: @user)

    assert_predicate import_order, :valid?
    assert_equal "release", import_order.kind
    assert_equal @code, import_order.code
  end

  def test_import_order_uri_type
    assert_nil @subject.uri

    @subject.uri = @uri

    assert_kind_of ImportOrderUri::Musicbrainz, @subject.uri
  end

  def test_with_a_valid_uri_and_a_kind
    import_order = MusicbrainzImportOrder.new(kind: "release", uri: @uri, user: users(:kim))

    assert_not_predicate import_order, :valid?
    assert_equal "release", import_order.kind
    assert_nil import_order.code
  end

  def test_with_a_valid_uri_and_code
    import_order = MusicbrainzImportOrder.new(code: @code, uri: "https://musicbrainz.org/non/sense", user: users(:kim))

    assert_not_predicate import_order, :valid?
    assert_nil import_order.kind
    assert_equal @code, import_order.code
  end

  def test_with_an_invalid_code
    import_order = MusicbrainzImportOrder.new(code: "no-uuid", kind: "release", user: users(:kim))

    assert_not_predicate import_order, :valid?
  end
end
