require "test_helper"
require "minitest/mock"

class IngestionFinder::MusicbrainzArtistCreditTest < ActiveSupport::TestCase
  setup do
    @facade = Minitest::Mock.new
    @finder = IngestionFinder::ArtistCredit.new
  end

  test "ArtistCredit does not exist" do
    @facade.expect :scrape, "Lee Aaron", [:name]

    assert_nil @finder.call(@facade)

    @facade.verify
  end

  test "ArtistCredit does exist" do
    lee_aaron = ArtistCredit.create!(name: "Lee Aaron")

    @facade.expect :scrape, "Lee Aaron", [:name]

    assert_equal lee_aaron, @finder.call(@facade)

    @facade.verify
  end
end
