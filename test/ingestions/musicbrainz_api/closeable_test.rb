require "test_helper"
require "minitest/mock"

class MusicbrainzApi::CloseableTest < ActiveSupport::TestCase
  setup do
    @open_api = Minitest::Mock.new
    @closeable = MusicbrainzApi::CloseableApi.new(@open_api)
    @uri = "https://example.org/nice/data"
  end

  test "#closed?" do
    assert_not @closeable.closed?

    @closeable.close!

    assert @closeable.closed?
  end

  test "calls the open_api when it is not closed" do
    @open_api.expect :get, :nice_data, [@uri]

    assert_equal :nice_data, @closeable.get(@uri)

    @open_api.verify
  end

  test "#get raises an error when closed" do
    @closeable.close!
    assert_raises(RuntimeError) { @closeable.get(@uri) }
  end
end
