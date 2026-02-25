require "test_helper"

class MusicbrainzApi::OpenApiTest < ActiveSupport::TestCase
  test "timeout calculations using default minimal_timeout" do
    config = {}
    open_api = MusicbrainzApi::OpenApi.new(config)

    assert_equal 1, open_api.send(:timeout_calculator).call(0)
    assert_equal 2, open_api.send(:timeout_calculator).call(1)
    assert_equal 5, open_api.send(:timeout_calculator).call(2)
    assert_equal 10, open_api.send(:timeout_calculator).call(3)
  end

  test "timeout calculations using minimal_timeout: 0.9" do
    config = {minimal_timeout: 0.9}
    open_api = MusicbrainzApi::OpenApi.new(config)

    assert_equal 0.9, open_api.send(:timeout_calculator).call(0)
    assert_equal 1.9, open_api.send(:timeout_calculator).call(1)
    assert_equal 4.9, open_api.send(:timeout_calculator).call(2)
    assert_equal 9.9, open_api.send(:timeout_calculator).call(3)
  end
end
