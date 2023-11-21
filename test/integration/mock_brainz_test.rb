require "test_helper"
require "support/web_mock_external_apis"

class MockBrainzTest < ActionDispatch::IntegrationTest
  setup do
    WebMockExternalApis.setup
  end

  def connection
    @connection ||= Faraday.new do |connection|
      connection.adapter Faraday.default_adapter
    end
  end

  test "foobar" do
    response = connection.get("https://musicbrainz.org/ws/2/hello/world")

    assert_predicate response, :success?
    assert_equal response.body, '{"hello": "world"}'
  end
end
