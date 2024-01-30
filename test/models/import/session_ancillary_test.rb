require "test_helper"
require "minitest/mock"

class Import::SessionAncillaryTest < ActiveSupport::TestCase
  setup do
    @buffer = Minitest::Mock.new
    @factory = Minitest::Mock.new

    @handler = Import::SessionAncillary.new(@factory)
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

  test "#deep_dup_buffer" do
    @factory.expect :buffer, @buffer
    @buffer.expect :deep_dup, {}

    assert_kind_of Hash, @handler.deep_dup_buffer

    @buffer.verify
    @factory.verify
  end

  test "get" do
    @factory.expect :buffer, @buffer
    @buffer.expect :fetch, :some_value, [:kind, :code]

    assert_equal @handler.get(:kind, :code), :some_value

    @buffer.verify
    @factory.verify
  end
end
