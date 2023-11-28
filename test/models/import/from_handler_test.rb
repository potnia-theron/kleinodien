require "test_helper"
require "minitest/mock"

class Import::FromHandlerTest < ActiveSupport::TestCase
  setup do
    @buffer = Minitest::Mock.new
    @factory = Minitest::Mock.new

    @handler = Import::FromHandler.new(@factory)
  end

  test "#buffered? false" do
    @factory.expect :buffer, @buffer
    @buffer.expect :buffered?, false, [:kind, :code]

    assert_not @handler.buffered?(:kind, :code)

    @buffer.verify
    @factory.verify
  end

  test "#buffered? true" do
    @factory.expect :buffer, @buffer
    @buffer.expect :buffered?, true, [:kind, :code]

    assert @handler.buffered?(:kind, :code)

    @buffer.verify
    @factory.verify
  end

  test "get" do
    @factory.expect :buffer, @buffer
    @buffer.expect :get, :some_value, [:kind, :code]

    assert_equal @handler.get(:kind, :code), :some_value

    @buffer.verify
    @factory.verify
  end
end
