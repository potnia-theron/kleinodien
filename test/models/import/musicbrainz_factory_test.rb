require "test_helper"

class Import::MusicbrainzFactoryTest < ActiveSupport::TestCase
  setup do
    @api = Import::MusicbrainzFactory.new(:fake_import_order)
  end

  # TODO: Tests for all methods
  test "build_uri" do
    assert_equal @api.build_uri(:artist, "66c662b6-6e2f-4930-8610-912e24c63ed1"), "https://musicbrainz.org/ws/2/artist/66c662b6-6e2f-4930-8610-912e24c63ed1?fmt=json"
  end
end
