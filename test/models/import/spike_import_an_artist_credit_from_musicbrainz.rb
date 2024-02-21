require "test_helper"
require "support/web_mock_external_apis"

class Import::SpikeImportAnArtistCreditFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup

    @session = Import::Session.new(:fake_import_order)
    @presenter = Import::MusicbrainzArtistCreditPresenter.new
    @aquirer = Import::Aquirer.new(@presenter)

    @artist_credit = @session
      .musicbrainz
      .get(:release, "36ddebf6-7fb2-4dc4-8931-aca5a3a35a30")
      .artist_credit
  end

  test "import an Participant" do
    @aquirer.aquire

    assert true
  end
end
