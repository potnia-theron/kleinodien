require "test_helper"

class FakeBuffer
  def get(kind, code)
    :some_value if kind == :with_value && code
  end

  # rubocop:disable Rails/HttpPositionalArguments
  def fetch(kind, code, &block)
    return block.call if block
    get(kind, code)
  end
  # rubocop:enable Rails/HttpPositionalArguments
end

class FakeFactory
  def buffer
    @buffer ||= FakeBuffer.new
  end
end

class Import::FromHandlerTest < ActiveSupport::TestCase
  setup do
    @handler = Import::FromHandler.new(FakeFactory.new)
  end

  test "get" do
    assert_nil @handler.get("some_kind", 123)
    assert_equal @handler.get(:with_value, 123), :some_value
  end

  test "fetch without block" do
    assert_nil @handler.fetch("some_kind", 123)
    assert_equal @handler.fetch(:with_value, 123), :some_value
  end

  test "fetch with block" do
    assert_equal @handler.fetch(:with_value, 123) { :block_value }, :block_value
  end
end
