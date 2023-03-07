require "test_helper"

class MusicBrainzImportOrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @import_order = music_brainz_import_orders(:music_brainz_one)
  end

  test "it schould be valid" do
    assert_predicate(@import_order, :valid?)
  end

  test "without a code it is not valid" do
    @import_order.code = nil

    assert_not @import_order.valid?
  end

  test "without a kind it is not valid" do
    @import_order.kind = nil

    assert_not @import_order.valid?
  end

  test "without a state it is not valid" do
    @import_order.state = nil

    assert_not @import_order.valid?
  end

  test "without a user it is not valid" do
    @import_order.user = nil

    assert_not @import_order.valid?
  end
end
