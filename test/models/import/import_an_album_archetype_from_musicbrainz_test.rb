require "test_helper"
require "support/web_mock_external_apis"

class Import::ImportAnAlbumArchetypeFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup
  end

  test "import an AlbumArchetype" do
    code = "f85647ec-a69b-3b0a-ad04-bb6076c4dcf1"
    user = users(:sam)
    import_order = MusicBrainzImportOrder.create!(code: code, kind: :album_archetype, user: user)
    handler = Import::MusicbrainzHandler.new(import_order)

    album_archetype = handler.call
    debugger if album_archetype.is_a? Symbol
    assert_equal code, album_archetype.musicbrainz_code
  end
end
