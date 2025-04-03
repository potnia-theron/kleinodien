require "test_helper"
require "minitest/mock"

class Import::OrderTest < ActiveSupport::TestCase
  setup do
    @import_order = Minitest::Mock.new
    @order = Import::Order.new(@import_order)
  end

  test "#class_name_component" do
    @import_order.expect :nil?, false # delegate_missing_to uses `#nil?`
    @import_order.expect :type, "FooImportOrder"

    assert_equal "Foo", @order.class_name_component

    @import_order.verify
  end
end
