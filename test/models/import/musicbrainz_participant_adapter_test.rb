require "test_helper"
require "minitest/mock"

class Import::MusicbrainzParticipantAdapterTest < ActiveSupport::TestCase
  setup do
    @code = "66c662b6-6e2f-4930-8610-912e24c63ed1" # AC/DC
    @factory = Minitest::Mock.new
    @from = Minitest::Mock.new

    @adapter = Import::MusicbrainzParticipantAdapter.new(@factory, code: @code)
  end

  def acdc
    File.read("test/webmock/musicbrainz.org/ws/2/artist/66c662b6-6e2f-4930-8610-912e24c63ed1_inc_url-rels.json")
  end

  test "#cheap_search_parameters" do
    assert_equal @adapter.cheap_search_parameters, {musicbrainz_code: @code}
  end

  test "#expensive_search_parameters" do
    @factory.expect :from, @from
    musicbrainz = Minitest::Mock.new
    @from.expect :musicbrainz, musicbrainz
    musicbrainz.expect :get, acdc, [:artist, @code]

    assert_equal @adapter.expensive_search_parameters, {discogs_code: "84752", musicbrainz_code: @code}
  end
end
