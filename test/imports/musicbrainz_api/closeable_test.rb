require "test_helper"
require "minitest/mock"

class MusicbrainzApi::CloseableTest < ActiveSupport::TestCase
  setup do
    @open_api = Minitest::Mock.new
    @closeable_api = MusicbrainzApi::Closeable.new(@open_api)
    @uri = "https://example.org/nice/data"
  end

  test "#closed?" do
    assert_not @closeable_api.closed?

    @closeable_api.close!

    assert @closeable_api.closed?
  end

  test "calls the open_api when it is not closed" do
    @open_api.expect :get, :nice_data, [@uri]

    assert_equal :nice_data, @closeable_api.get(@uri)

    @open_api.verify
  end

  test "#get raises an error when closed" do
    @closeable_api.close!
    assert_raises(RuntimeError) { @closeable_api.get(@uri) }
  end
end
