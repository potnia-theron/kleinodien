require "test_helper"
require "minitest/mock"

class Import::ArtistCreditParticipantFinderTest < ActiveSupport::TestCase
  test "#find returns nil" do
    # Well, for now Import::ArtistCreditParticipantFinder#find returns always nil.
    # So this test seems a little bloated.
    facade = Minitest::Mock.new
    order = Minitest::Mock.new

    assert_nil Import::ArtistCreditParticipantFinder.call(order, facade: facade)

    facade.verify
    order.verify
  end
end
