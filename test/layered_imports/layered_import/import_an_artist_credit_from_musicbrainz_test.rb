require "test_helper"
require "support/web_mock_external_apis"

class LayeredImport::ImportAnArtistCreditFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup
  end

  test "import an ArtistCredit from MusicBrainz" do
    code = "36ddebf6-7fb2-4dc4-8931-aca5a3a35a30" # The Sky Is Falling and I Want My Mommy
    user = users(:sam)

    import_order = MusicbrainzImportOrder.create!(code: code, kind: :artist_credit, user: user)

    artist_credit = LayeredImport.ignite(import_order)

    assert_not artist_credit.new_record?
    assert_equal "Jello Biafra With NoMeansNo", artist_credit.name

    assert_equal 2, artist_credit.participants.length
    artist_credit.participants.each_with_index do |ac_participant, idx|
      assert_equal ac_participant.position, idx
      assert_not ac_participant.new_record?
      assert_not ac_participant.participant.new_record?
    end
  end
end
