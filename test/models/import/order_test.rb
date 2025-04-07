require "test_helper"
require "minitest/mock"

class Import::OrderTest < ActiveSupport::TestCase
  setup do
    @import_order = Minitest::Mock.new
    @order = Import::Order.new(@import_order)
  end

  # test "#class_name_component" do
  #   assert true
  # end
end
