require "test_helper"
require "minitest/mock"

class IngestionFinder::AlbumArchetypeTest < ActiveSupport::TestCase
  setup do
    @order = Minitest::Mock.new
    @facade = Minitest::Mock.new
  end

  test "#find returns nil if AlbumArchetype does not exist" do
    @facade.expect :cheap_codes, {discogs_code: 333}
    @facade.expect :all_codes, {discogs_code: 333, musicbrainz_code: "5ec4b261-1afe-4588-9ff7-90b1b32c9dec"}

    assert_nil IngestionFinder::AlbumArchetype.call(@order, @facade)

    @facade.verify
    @order.verify
  end

  test "#find_by_cheap_codes returns the AlbumArchetype if it exists" do
    musicbrainz_code = "18c8ecb4-c9fd-4b14-9b2e-249ea3e8c821"
    album_archetype = album_archetypes(:one)
    album_archetype.update!(musicbrainz_code: musicbrainz_code)

    @facade.expect :cheap_codes, {musicbrainz_code: musicbrainz_code}

    assert_equal album_archetype, IngestionFinder::AlbumArchetype.call(@order, @facade)

    @facade.verify
    @order.verify
  end

  test "#find_by_all_codes returns the AlbumArchetype it exists" do
    musicbrainz_code = "18c8ecb4-c9fd-4b14-9b2e-249ea3e8c821"
    album_archetype = album_archetypes(:one)
    album_archetype.update!(musicbrainz_code: musicbrainz_code)

    @facade.expect :cheap_codes, {discogs_code: 333}
    @facade.expect :all_codes, {musicbrainz_code: musicbrainz_code}

    assert_equal album_archetype, IngestionFinder::AlbumArchetype.call(@order, @facade)

    @facade.verify
    @order.verify
  end
end
