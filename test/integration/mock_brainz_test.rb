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

  test "get ACDC" do
    uri_string = "https://musicbrainz.org/ws/2/artist/66c662b6-6e2f-4930-8610-912e24c63ed1"
    response = connection.get(uri_string)

    assert_predicate response, :success?
  end
end
