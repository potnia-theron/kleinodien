require "test_helper"

class Import::BufferTest < ActiveSupport::TestCase
  setup do
    @buffer = Import::Buffer.new
  end

  test "#buffered?" do
    assert_not @buffer.buffered?(:aphrodites_child, 666)

    @buffer.fetch(:aphrodites_child, 666) { "Irene Papas" }

    assert @buffer.buffered?("aphrodites_child", "666")
    assert @buffer.buffered?("aphrodites_child", 666)
  end

  test "#dump" do
    assert_empty @buffer.dump

    @buffer.fetch("foo", :bar) { :baz }

    assert_not_empty @buffer.dump
  end

  test "#fetch" do
    assert_nil @buffer.fetch(:foo, "bar")
    assert_equal @buffer.fetch("foo", :bar) { :baz }, :baz
    assert_equal @buffer.fetch("foo", :bar), :baz
  end
end
