require "test_helper"
require "support/web_mock_external_apis"

class Import::ImportAnAlbumArchetypeFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup

    @session = Import::MusicbrainzSession.new(:fake_import_order)

    @album_archetype = @session
      .get(:release_group, "f85647ec-a69b-3b0a-ad04-bb6076c4dcf1")
    @facade = @session.build_facade(AlbumArchetype, data: @album_archetype)

    @handler = Import::Handler.new(@facade)
  end

  test "import an AlbumArchetype" do
    archetype = @handler.call

    assert_equal "f85647ec-a69b-3b0a-ad04-bb6076c4dcf1", archetype.musicbrainz_code
    # assert_equal "Highway to Hell", archetype.title
  end
end
