require "test_helper"
require "minitest/mock"
require "support/shared_null_finder_tests"

class Import::ArtistCreditParticipantFinderTest < ActiveSupport::TestCase
  include SharedNullFinderTests

  setup do
    @finder_class = Import::ArtistCreditParticipantFinder
  end
end
