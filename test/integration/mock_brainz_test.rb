require "test_helper"
require "webmock/minitest"
require "support/web_mock_music_brainz"

class MockBrainzTest < ActionDispatch::IntegrationTest
  def connection
    @connection ||= Faraday.new do |connection|
      connection.adapter Faraday.default_adapter
    end
  end

  test "foobar" do
    WebMock.stub_request(:any, /musicbrainz.org/).to_rack(WebMockMusicBrainz)
    response = connection.get("https://musicbrainz.org/ws/2/hello/world")

    assert_predicate response, :success?
    assert_equal response.body, '{"hello": "world"}'
  end
end
