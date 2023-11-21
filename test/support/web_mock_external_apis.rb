require "test_helper"
require "webmock/minitest"
require "support/web_mock_music_brainz"

module WebMockExternalApis
  def self.setup
    WebMock.enable!
    WebMock.stub_request(:any, /musicbrainz.org/).to_rack(WebMockMusicBrainz)
  end
end
