require "test_helper"
require "minitest/mock"
require "support/shared_null_finder_tests"

class IngestionFinder::ArtistCreditParticipantTest < ActiveSupport::TestCase
  include SharedNullFinderTests

  setup do
    @finder = IngestionFinder::ArtistCreditParticipant.new
    @facade = Minitest::Mock.new
  end
end
