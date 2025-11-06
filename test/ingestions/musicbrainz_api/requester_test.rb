require "test_helper"
require "minitest/mock"

class MusicbrainzApi::RequesterTest < ActiveSupport::TestCase
  setup do
    @api = Minitest::Mock.new
    @uri_builder = Minitest::Mock.new
    @closeable_api = Minitest::Mock.new
    @requester = MusicbrainzApi::Requester.new(@api, @closeable_api, @uri_builder)
  end

  test "#closed?" do
    @closeable_api.expect :closed?, false
    assert_not @requester.closed?

    @closeable_api.expect :closed?, true
    assert @requester.closed?

    @closeable_api.verify
  end

  test "#closed!" do
    @closeable_api.expect :close!, true

    assert @requester.close!

    @closeable_api.verify
  end
end
