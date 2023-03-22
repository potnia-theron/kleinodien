# require "test_helper"

module SharedImportOrderTests
  def test_import_order_is_valid
    assert_predicate(@import_order, :valid?)
  end

  def test_without_a_code_it_is_not_valid
    @import_order.code = nil

    assert_not @import_order.valid?
  end

  def test_without_a_kind_it_is_not_valid
    @import_order.kind = nil

    assert_not @import_order.valid?
  end

  # def test_without_a_state_it_is_not_valid
  #   @import_order.state = nil

  #   assert_not @import_order.valid?
  # end

  # def test_with_an_illegal_state
  #   assert_raises(ArgumentError) { @import_order.state = :illegal_state }
  # end

  def test_without_a_user_it_is_not_valid
    @import_order.user = nil

    assert_not @import_order.valid?
  end
end
