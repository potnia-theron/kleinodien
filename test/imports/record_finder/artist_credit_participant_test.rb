require "test_helper"
require "minitest/mock"
require "support/shared_null_finder_tests"

class RecordFinder::ArtistCreditParticipantTest < ActiveSupport::TestCase
  include SharedNullFinderTests

  setup do
    @finder = RecordFinder::ArtistCreditParticipant.new
    @facade = Minitest::Mock.new
  end
end
