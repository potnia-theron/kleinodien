require "test_helper"
require "support/web_mock_external_apis"

class Import::ImportAnAlbumArchetypeFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup
  end

  test "import an AlbumArchetype" do
    # code = "f85647ec-a69b-3b0a-ad04-bb6076c4dcf1" # Highway to Hell
    code = "9a6f9e35-d05f-3f2b-b2b9-af7f8e619aca" # Twilight of the Thunder God
    user = users(:sam)

    import_order = MusicbrainzImportOrder.create!(code: code, kind: :album_archetype, user: user)
    handler = Import::MusicbrainzHandler.new(import_order)

    archetype = handler.call

    assert_equal "done", import_order.state
    assert_equal code, archetype.musicbrainz_code
  end
end
