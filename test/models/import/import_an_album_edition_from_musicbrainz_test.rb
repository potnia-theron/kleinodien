require "test_helper"
require "minitest/mock"
require "support/web_mock_external_apis"

class Import::ImportAnAlbumEditionFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup
  end

  test "Highway to Hell" do
    code = "8866e226-7cd6-414e-b7d2-6ae0b0df6715"
    user = users(:kim)
    import_order = MusicbrainzImportOrder.create!(code: code, kind: "album-edition", user: user)

    album_edition = Import.ignite(import_order)

    assert_kind_of AlbumEdition, album_edition

    edition = album_edition.edition
    assert_kind_of Edition, edition
    # TODO: make the following assertions pass
    # assert_equal "Highway To Hell", edition.title
    # assert_equal "AC/DC", edition.artist_credit.name
  end
end
