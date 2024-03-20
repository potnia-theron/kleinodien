require "test_helper"
require "support/web_mock_external_apis"

class Import::ImportAParticipantFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup

    @code = "66c662b6-6e2f-4930-8610-912e24c63ed1"
    @session = Import::MusicbrainzSession.new(:fake_import_order)
  end

  test "import a Participant with already fetched data" do
    participant = @session
      .musicbrainz
      .get(:artist, "66c662b6-6e2f-4930-8610-912e24c63ed1")
    facade = @session.build_facade(Participant, data: participant)
    handler = Import::Handler.new(facade)

    persisted = handler.call

    assert_equal persisted.name, "AC/DC"
    assert_not persisted.new_record?
  end

  test "import a Participant partialy fetched data" do
    facade = @session.build_facade(Participant, code: @code)
    handler = Import::Handler.new(facade)

    persisted = handler.call

    assert_equal persisted.name, "AC/DC"
    assert_not persisted.new_record?
  end

  test "don't import if a Participant with that musicbrainz_code already exists" do
    existing = Participant.create!(name: "Not AC/DC", sort_name: "AC/DC, Not", musicbrainz_code: @code)
    facade = @session.build_facade(Participant, code: @code)
    handler = Import::Handler.new(facade)

    persisted = handler.call

    assert_equal persisted, existing
  end

  test "don't import if a Participant with that discogs_code already exists" do
    existing = Participant.create!(name: "Not AC/DC", sort_name: "AC/DC, Not", discogs_code: 84752)
    facade = @session.build_facade(Participant, code: @code)
    handler = Import::Handler.new(facade)

    persisted = handler.call

    assert_equal persisted, existing
  end
end
