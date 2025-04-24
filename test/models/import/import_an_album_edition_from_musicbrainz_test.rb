require "test_helper"
require "minitest/mock"
require "support/web_mock_external_apis"

class Import::ImportAnAlbumEditionFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup
  end

  test "Highway to Hell" do
    code = "8866e226-7cd6-414e-b7d2-6ae0b0df6715"
    # user = users(:kim)
    musicbrainz_import_order = MusicbrainzImportOrder.create!(code: code, kind: "album-edition") # , user: user)
    import_order = ImportOrder.create!(import_orderable: musicbrainz_import_order)

    album_edition = Import.ignite(import_order)

    assert_kind_of AlbumEdition, album_edition

    edition = album_edition.edition
    assert_kind_of Edition, edition
    assert_equal "Highway to Hell", edition.archetype.title
    assert_equal "AC/DC", edition.archetype.artist_credit.name
    assert_not edition.new_record?
    assert_not edition.sections.first.positions.first.new_record?
  end
end
