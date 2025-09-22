require "test_helper"
require "minitest/mock"

class IngestionFinder::MusicbrainzArtistCreditTest < ActiveSupport::TestCase
  setup do
    @facade = Minitest::Mock.new
    @finder = IngestionFinder::ArtistCredit.new
  end

  test "ArtistCredit does not exist" do
    @facade.expect :name, "Lee Aaron"

    assert_nil @finder.call(@facade)

    @facade.verify
  end

  test "ArtistCredit does exist" do
    lee_aaron = ArtistCredit.create!(name: "Lee Aaron")

    @facade.expect :name, "Lee Aaron"

    assert_equal lee_aaron, @finder.call(@facade)

    @facade.verify
  end
end
