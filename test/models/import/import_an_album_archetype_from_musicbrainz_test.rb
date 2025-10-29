require "test_helper"
require "minitest/mock"
require "support/deeply_persisted"
require "support/web_mock_external_apis"

class Import::ImportAnAlbumArchetypeFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup
  end

  test "Twilight of the Thunder God" do
    code = "9a6f9e35-d05f-3f2b-b2b9-af7f8e619aca"
    user = users(:kim)
    # The kind of that import_order is wrong. The musicbrainz-kind is "release-group".
    # ... but for testing...
    musicbrainz_import_order = MusicbrainzImportOrder.create!(code: code, kind: "album_archetype")
    import_order = ImportOrder.create!(import_orderable: musicbrainz_import_order, user: user)

    album_archetype = Import.ignite(import_order)
    assert_deeply_persisted album_archetype
    assert_kind_of AlbumArchetype, album_archetype

    archetype = album_archetype.archetype
    assert_kind_of Archetype, archetype
    assert_equal "Twilight of the Thunder God", archetype.title
    assert_equal "Amon Amarth", archetype.artist_credit.name
  end
end
