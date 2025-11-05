require "test_helper"
require "minitest/mock"

class MusicbrainzApi::RequesterTest < ActiveSupport::TestCase
  setup do
    @api = Minitest::Mock.new
    @uri_builder = Minitest::Mock.new
    @closeable = Minitest::Mock.new
    @requester = MusicbrainzApi::Requester.new(@api, @closeable, @uri_builder)
  end

  test "#closed?" do
    @closeable.expect :closed?, false
    assert_not @requester.closed?

    @closeable.expect :closed?, true
    assert @requester.closed?

    @closeable.verify
  end

  test "#closed!" do
    @closeable.expect :close!, true

    assert @requester.close!

    @closeable.verify
  end
end
