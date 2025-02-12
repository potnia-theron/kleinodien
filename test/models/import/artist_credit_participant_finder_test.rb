require "test_helper"
require "minitest/mock"

class Import::ArtistCreditParticipantFinderTest < ActiveSupport::TestCase
  test "#find returns nil" do
    # Well, for now Import::ArtistCreditParticipantFinder#find returns always nil.
    # So this test seems a little bloated.
    facade = Minitest::Mock.new
    order = Minitest::Mock.new

    finder = Import::ArtistCreditParticipantFinder.new(order, facade: facade)

    assert_nil finder.find

    facade.verify
    order.verify
  end
end
