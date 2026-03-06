require "test_helper"
require "minitest/mock"

class MusicbrainzApi::BufferTest < ActiveSupport::TestCase
  setup do
    @api = Minitest::Mock.new
    @buffer = MusicbrainzApi::Buffer.new(@api)
    @uri_string = "https://example.com"
  end

  test "#get" do
    @api.expect :get, :buffered_result, [@uri_string]

    assert_equal @buffer.get(@uri_string), :buffered_result

    @api.verify
  end
end
