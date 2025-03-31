require "test_helper"
# require "support/shared_import_order_tests"

class ImportOrderTest < ActiveSupport::TestCase
  test "derive kind and code from a MusicBrainz uri" do
    import_order = ImportOrder.new(
      state: "open",
      uri: "https://musicbrainz.org/release/45eb569a-da08-49d5-8735-21a3a169fdee",
      user: users(:kim)
    )

    assert import_order.valid?
    assert_equal "release", import_order.kind
    assert_equal "45eb569a-da08-49d5-8735-21a3a169fdee", import_order.code
  end
end
