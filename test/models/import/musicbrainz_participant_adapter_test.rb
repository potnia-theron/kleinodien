require "test_helper"
require "minitest/mock"

class Import::MusicbrainzParticipantAdapterTest < ActiveSupport::TestCase
  setup do
    @code = "66c662b6-6e2f-4930-8610-912e24c63ed1" # AC/DC

    @ancillary = Minitest::Mock.new
    @session = Minitest::Mock.new
  end

  def acdc
    json_string = File.read("test/webmock/musicbrainz.org/ws/2/artist/66c662b6-6e2f-4930-8610-912e24c63ed1_inc_url-rels.json")
    Import::Json.parse(json_string)
  end

  test "#prepare with code" do
    adapter = Import::MusicbrainzParticipantAdapter.new(@session, code: @code)
    @session.expect :musicbrainz, @ancillary
    @ancillary.expect :get, acdc, [:artist, @code]

    adapter.prepare

    @ancillary.verify
    @session.verify
  end

  test "#prepare with data" do
    adapter = Import::MusicbrainzParticipantAdapter.new(@session, data: acdc)
    assert_nil adapter.prepare
  end
end
