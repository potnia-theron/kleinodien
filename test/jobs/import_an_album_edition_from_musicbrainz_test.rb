require "test_helper"
require "minitest/mock"
require "support/deeply_persisted"
require "support/web_mock_external_apis"

class ImportAnAlbumEditionFromMusicbrainzTest < ActiveJob::TestCase
  setup do
    WebMockExternalApis.setup
  end

  test "Highway to Hell" do
    code = "8866e226-7cd6-414e-b7d2-6ae0b0df6715"
    user = users(:sam)
    musicbrainz_import_order = MusicbrainzImportOrder.create!(code: code, kind: "album-edition")
    import_order = ImportOrder.create!(import_orderable: musicbrainz_import_order, user: user)

    perform_enqueued_jobs do
      MusicbrainzImportJob.perform_later(import_order)
    end

    album_edition = AlbumEdition.find_by(musicbrainz_code: code)
    assert_deeply_persisted album_edition
    assert_kind_of AlbumEdition, album_edition

    edition = album_edition.edition
    assert_kind_of Edition, edition

    archetype = edition.archetype
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
  end
end
