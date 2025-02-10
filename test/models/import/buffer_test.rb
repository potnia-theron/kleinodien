require "test_helper"
require "minitest/mock"

class Import::BufferTest < ActiveSupport::TestCase
  setup do
    @order = Minitest::Mock.new
    @buffer = Import::Buffer.new(@order)
    @uri_string = "https://example.com"
  end

  test "#buffered?" do
    assert_not @buffer.buffered?(@uri_string)

    @order.expect :buffering?, true
    @buffer.fetch(@uri_string) { "Irene Papas" }

    assert @buffer.buffered?(@uri_string)
    assert @buffer.buffered?(@uri_string)

    @order.verify
  end

  test "#deep_dup" do
    assert_empty @buffer.deep_dup

    @order.expect :buffering?, true
    @buffer.fetch(@uri_string) { :baz }

    assert_not_empty @buffer.deep_dup

    @order.verify
  end

  test "#fetch" do
    assert_nil @buffer.fetch(@uri_string)

    @order.expect :buffering?, true
    assert_equal @buffer.fetch(@uri_string) { :baz }, :baz
    assert_equal @buffer.fetch(@uri_string), :baz

    @order.verify
  end

  test "#buffered? with wrong arguments" do
    assert_raises(ArgumentError) { @buffer.buffered?("foo", "bar") }
  end

  test "#fetch with wrong arguments" do
    assert_raises(ArgumentError) { @buffer.fetch(:foo, :bar, :baz) }
    assert_raises(ArgumentError) { @buffer.fetch(:foo, :bar, :baz) { :blubber } }
  end

  test "#fetch with block when order#buffering? returns false" do
    @order.expect :buffering?, false
    assert_raises(RuntimeError) { @buffer.fetch(@uri_string) { :blubber } }

    @order.verify
  end

  test "#fetch without block when order#buffering? returns false" do
    assert_nil @buffer.fetch(@uri_string)

    @order.verify
  end
end
