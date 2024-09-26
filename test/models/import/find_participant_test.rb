require "test_helper"
require "support/shared_import_find_tests"

# Mocking is difficult here because there is a lot of delegation going on.
# So we use a simple object.
class FakeFacade
  def initialize(model_class:)
    @all_codes = {}
    @cheap_codes = {}
    @model_class = model_class
  end

  attr_accessor :all_codes, :cheap_codes, :model_class
end

class Import::FindParticipantTest < ActiveSupport::TestCase
  include SharedImportFindTests

  setup do
    @facade = FakeFacade.new(model_class: Participant)
    @subject = Import::FindParticipant.new(:fake_session, facade: @facade)
  end

  def cannot_find
    @subject
  end

  def create_participant
    Participant.create!(name: "Airbourne", sort_name: "Airbourne", musicbrainz_code: musicbrainz_code)
  end

  def musicbrainz_code = "a025df46-e2a5-11ee-9be0-33eaef18f872"

  test "find Participant with #cheap_codes" do
    create_participant

    @facade.cheap_codes = {musicbrainz_code: musicbrainz_code}

    assert_equal "Airbourne", @subject.call.name
  end

  test "find Participant with #all_codes" do
    create_participant

    @facade.all_codes = {musicbrainz_code: musicbrainz_code}

    assert_equal "Airbourne", @subject.call.name
  end
end
