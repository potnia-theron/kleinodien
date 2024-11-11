require "test_helper"
require "minitest/mock"
require "support/shared_import_find_tests"

class Import::FindParticipantTest < ActiveSupport::TestCase
  include SharedImportFindTests

  setup do
    @facade = Minitest::Mock.new
    @subject = Import::FindParticipant.new(:fake_session, facade: @facade)
  end

  def cannot_find
    @facade.expect :cheap_codes, {}
    @facade.expect :all_codes, {}
    @subject
  end

  def create_participant
    Participant.create!(name: "Airbourne", sort_name: "Airbourne", musicbrainz_code: musicbrainz_code)
  end

  def musicbrainz_code = "a025df46-e2a5-11ee-9be0-33eaef18f872"

  test "find Participant with #cheap_codes" do
    create_participant

    @facade.expect :cheap_codes, {musicbrainz_code: musicbrainz_code}
    @facade.expect :model_class, Participant

    assert_equal "Airbourne", @subject.call.name

    @facade.verify
  end

  test "find Participant with #all_codes" do
    create_participant

    @facade.expect :cheap_codes, {}
    @facade.expect :all_codes, {musicbrainz_code: musicbrainz_code}
    @facade.expect :model_class, Participant

    assert_equal "Airbourne", @subject.call.name

    @facade.verify
  end
end
