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

  def build_fetcher(uri_string)
    fetcher = Minitest::Mock.new
    fetcher.expect :get, :some_value

    fetcher
  end

  def build_uri(*) = "https://example.com"
end

class Import::FromHandlerTest < ActiveSupport::TestCase
  setup do
    @handler = Import::FromHandler.new(FakeFactory.new)
  end

  test "get" do
    assert_equal @handler.get(:with_value, 123), :some_value
  end
end
