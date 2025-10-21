require "test_helper"
require "minitest/mock"
require "support/deeply_persisted"
require "support/web_mock_external_apis"

class Import::ImportAnAlbumEditionFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup
  end

  test "Highway to Hell" do
    code = "8866e226-7cd6-414e-b7d2-6ae0b0df6715"
    user = users(:sam)
    musicbrainz_import_order = MusicbrainzImportOrder.create!(code: code, kind: "album-edition")
    import_order = ImportOrder.create!(import_orderable: musicbrainz_import_order, user: user)

    album_edition = Import.ignite(import_order)
    assert_deeply_persisted album_edition
    assert_not album_edition.new_record?
    assert_kind_of AlbumEdition, album_edition

    edition = album_edition.edition
    assert_not edition.new_record?
    assert_kind_of Edition, edition
    # assert_not edition.sections.first.positions.first.new_record?

    archetype = edition.archetype
    assert_not archetype.new_record?
    assert_equal "Highway to Hell", archetype.title
    assert_equal "AC/DC", archetype.artist_credit.name

    sections = edition.sections
    assert_equal 1, sections.length

    positions = sections.first.positions
    assert_equal 10, positions.length
    assert_equal 10, positions
      .map { it.edition.editionable }
      .filter { it.instance_of?(::SongEdition) }
      .length
    assert positions.all? { it.edition.editionable.instance_of?(SongEdition) }

    album_archetype = archetype.archetypeable
    assert_not album_archetype.new_record?
  end
end
