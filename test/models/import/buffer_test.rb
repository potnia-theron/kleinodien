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

  # test "freeze" do
  #   @buffer.fetch("foo", :bar, "baz") { :blubber }
  #   @buffer.freeze

  #   assert_predicate @buffer, :frozen?
  #   assert_equal @buffer.fetch("foo", "bar", :baz), :blubber
  # end

  test "musicbrainz" do
    assert_nil @buffer.musicbrainz.fetch(:foo, "bar")

    assert_equal @buffer.musicbrainz.fetch("foo", :bar) { :baz }, :baz
    assert_equal @buffer.musicbrainz.fetch(:foo, "bar") { :baz }, :baz
  end
end
