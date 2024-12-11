require "test_helper"
require "minitest/mock"

class LayeredImport::TestFooBarFacade
  def initialize(import_order)
    @import_order = import_order
  end

  attr_reader :import_order
end

class LayeredImport::OrderTest < ActiveSupport::TestCase
  setup do
    @import_order = Minitest::Mock.new
    @order = LayeredImport::Order.new(@import_order)
  end
  test "#class_name_component" do
    @import_order.expect :nil?, false # delegate_missing_to uses `#nil?`
    @import_order.expect :type, "FooImportOrder"

    assert_equal "Foo", @order.class_name_component

    @import_order.verify
  end

  test "#embed_class_name_component" do
    @import_order.expect :nil?, false
    @import_order.expect :type, "FooImportOrder"

    assert_equal "Blubber::FooBar", @order.embed_class_name_component("Blubber::", "Bar")

    @import_order.verify
  end

  test "#create_facade_layer" do
    @import_order.expect :nil?, false
    @import_order.expect :type, "TestFooBarImportOrder"

    facade = @order.create_facade_layer

    assert_kind_of LayeredImport::TestFooBarFacade, facade

    @import_order.verify
  end
end
