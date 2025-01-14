require "test_helper"
require "minitest/mock"

class LayeredImport::BufferTest < ActiveSupport::TestCase
  setup do
    @order = Minitest::Mock.new
    @buffer = LayeredImport::Buffer.new(@order)
  end

  test "#buffered?" do
    assert_not @buffer.buffered?(:aphrodites_child, 666)

    @order.expect :buffering?, true
    @buffer.fetch(:aphrodites_child, 666) { "Irene Papas" }

    assert @buffer.buffered?("aphrodites_child", "666")
    assert @buffer.buffered?("aphrodites_child", 666)

    @order.verify
  end

  test "#deep_dup" do
    assert_empty @buffer.deep_dup

    @order.expect :buffering?, true
    @buffer.fetch("foo", :bar) { :baz }

    assert_not_empty @buffer.deep_dup

    @order.verify
  end

  test "#fetch" do
    assert_nil @buffer.fetch(:foo, "bar")

    @order.expect :buffering?, true
    assert_equal @buffer.fetch("foo", :bar) { :baz }, :baz
    assert_equal @buffer.fetch("foo", :bar), :baz

    @order.verify
  end

  test "#buffered? with wrong arguments" do
    assert_raises(ArgumentError) { @buffer.buffered?(:foo) }
    assert_raises(ArgumentError) { @buffer.buffered?(:foo, :bar, :baz) }
  end

  test "#fetch with wrong arguments" do
    assert_raises(ArgumentError) { @buffer.fetch(:foo) }
    assert_raises(ArgumentError) { @buffer.fetch(:foo, :bar, :baz) }
    assert_raises(ArgumentError) { @buffer.fetch(:foo, :bar, :baz) { :blubber } }
  end

  test "#fetch with block when order#buffering? returns false" do
    @order.expect :buffering?, false
    assert_raises(RuntimeError) { @buffer.fetch("foo", :bar) { :blubber } }

    @order.verify
  end

  test "#fetch without block when order#buffering? returns false" do
    assert_nil @buffer.fetch("foo", :bar)

    @order.verify
  end
end
