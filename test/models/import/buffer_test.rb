require "test_helper"

class Import::BufferTest < ActiveSupport::TestCase
  setup do
    @buffer = Import::Buffer.new
  end

  test "fetch" do
    assert_nil @buffer.fetch(:foo, "bar")

    assert_equal @buffer.fetch("foo", :bar) { :baz }, :baz
    assert_equal @buffer.fetch("foo", :bar), :baz
  end

  test "musicbrainz" do
    assert_nil @buffer.musicbrainz.fetch(:foo, "bar")

    assert_equal @buffer.musicbrainz.fetch("foo", :bar) { :baz }, :baz
    assert_equal @buffer.musicbrainz.fetch(:foo, "bar") { :baz }, :baz
  end
end
