require "test_helper"
require "minitest/mock"
require "support/web_mock_external_apis"

class Import::ImportAParticipantFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup
  end

  test "import NoMeansNo" do
    code = "37e9d7b2-7779-41b2-b2eb-3685351caad3" # NoMeansNo
    # user = users(:kim)
    import_order = MusicbrainzImportOrder.create!(code: code, kind: "participant") # , user: user)
    import_order.buffering!

    participant ||= Import.ignite(import_order)

    assert_equal "NoMeansNo", participant.name
    # TODO: reactivate tests on ???_date
    # assert_equal "1979-01-01", participant.begin_date.to_s
    # assert_equal "2016-09-24", participant.end_date.to_s
    assert_equal 133641, participant.discogs_code
    assert_equal "nm2012163", participant.imdb_code
    assert_equal code, participant.musicbrainz_code
    assert_equal 1430380, participant.wikidata_code
    assert_not participant.new_record?
    # TODO: add more specific tests on Participant#links
    assert_not_empty participant.links
  end
end
