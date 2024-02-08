require "test_helper"
require "minitest/mock"

class Import::MusicbrainzParticipantAdapterTest < ActiveSupport::TestCase
  MusicbrainzTestData = Data.define(:relations)
  MusicbrainzTestRelation = Data.define(:target_type, :type, :url)
  MusicbrainzTestUrl = Data.define(:resource)

  setup do
    @musicbrainz_code = "66c662b6-6e2f-4930-8610-912e24c63ed1" # AC/DC
    @discogs_code = 84752

    @ancillary = Minitest::Mock.new
    @session = Minitest::Mock.new
  end

  def acdc
    json_string = File.read("test/webmock/musicbrainz.org/ws/2/artist/66c662b6-6e2f-4930-8610-912e24c63ed1_inc_url-rels.json")
    Import::Json.parse(json_string)
  end

  test "#prepare with code when no record can be found" do
    adapter = Import::MusicbrainzParticipantAdapter.new(@session, code: @musicbrainz_code)
    @session.expect :musicbrainz, @ancillary
    @ancillary.expect :get, acdc, [:artist, @musicbrainz_code]

    adapter.prepare

    @ancillary.verify
    @session.verify
  end

  test "#prepare with code when the record already exists" do
    participants(:one).update!(musicbrainz_code: @musicbrainz_code)
    adapter = Import::MusicbrainzParticipantAdapter.new(@session, code: @musicbrainz_code)

    assert_equal adapter.prepare.musicbrainz_code, @musicbrainz_code
  end

  test "#prepare with existing record and various code-columns" do
    test_values = [
      ["discogs_code", "123", "discogs", "https://discogs.com/artist/123"],
      ["imdb_code", "nm333", "IMDb", "https://imdb.com/name/nm333"]
    ]

    test_values.each do |test_data|
      code_column, code, type, url = test_data
      @session.expect :musicbrainz, @ancillary
      @ancillary.expect :get, acdc, [:artist, @musicbrainz_code]

      Participant.create!(:name => "AC/DC", :sort_name => "AC/DC", code_column => code)

      url_obj = MusicbrainzTestUrl.new(url)
      relation = MusicbrainzTestRelation.new(target_type: "url", type: type, url: url_obj)
      data = MusicbrainzTestData.new([relation])
      adapter = Import::MusicbrainzParticipantAdapter.new(@session, data: data, code: @musicbrainz_code)

      assert_equal adapter.prepare.name, "AC/DC"
    end
  end

  test "#prepare with data when no record can be found" do
    adapter = Import::MusicbrainzParticipantAdapter.new(@session, data: acdc)
    assert_nil adapter.prepare
  end

  test "#prepare with data when the record already exists" do
    participants(:one).update!(discogs_code: @discogs_code)
    adapter = Import::MusicbrainzParticipantAdapter.new(@session, data: acdc)
    assert_equal adapter.prepare.discogs_code, @discogs_code
  end

  test "#persist" do
    adapter = Import::MusicbrainzParticipantAdapter.new(@session, code: @musicbrainz_code)

    @session.expect :musicbrainz, @ancillary
    @ancillary.expect :get, acdc, [:artist, @musicbrainz_code]

    participant = adapter.persist!
    assert_not participant.new_record?
    assert_equal participant.name, "AC/DC"

    @session.verify
    @ancillary.verify
  end
end
