require "test_helper"
require "minitest/mock"

class IngestionFinder::ParticipantTest < ActiveSupport::TestCase
  setup do
    @order = Minitest::Mock.new
    @facade = Minitest::Mock.new
  end
  test "participant does not exist" do
    @facade.expect :cheap_codes, {}
    @facade.expect :all_codes, {}

    assert_nil IngestionFinder::Participant.call(@order, @facade)

    @order.verify
    @facade.verify
  end

  test "participant can be found by #cheap_codes" do
    existing_participant = Participant.create!(name: "Abdul Alhazred", discogs_code: 123)

    @facade.expect :cheap_codes, {discogs_code: 123}

    assert_equal existing_participant, IngestionFinder::Participant.call(@order, @facade)

    @order.verify
    @facade.verify
  end

  test "participant can be found by #all_codes" do
    existing_participant = Participant.create!(name: "Nicole", tmdb_code: 321)

    @facade.expect :cheap_codes, {}
    @facade.expect :all_codes, {tmdb_code: 321}

    assert_equal existing_participant, IngestionFinder::Participant.call(@order, @facade)

    @order.verify
    @facade.verify
  end
end
