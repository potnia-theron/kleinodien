require "test_helper"
require "minitest/mock"

class Import::MusicbrainzArtistCreditFinderTest < ActiveSupport::TestCase
  setup do
    @order = Minitest::Mock.new
    @facade = Minitest::Mock.new
  end

  test "ArtistCredit does not exist" do
    @order.expect :buffering?, true
    @facade.expect :name, "Lee Aaron"

    assert_nil Import::ArtistCreditFinder.new(@order, facade: @facade).find

    @order.verify
    @facade.verify
  end

  test "ArtistCredit does exist" do
    lee_aaron = ArtistCredit.create!(name: "Lee Aaron")

    @order.expect :buffering?, true
    @facade.expect :name, "Lee Aaron"

    assert_equal lee_aaron, Import::ArtistCreditFinder.new(@order, facade: @facade).find

    @order.verify
    @facade.verify
  end
end
