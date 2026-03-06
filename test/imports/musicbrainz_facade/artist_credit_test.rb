require "test_helper"
require "minitest/mock"
require "support/retrieve"
require "support/retrieve/musicbrainz"
require "support/web_mock_external_apis"

class MusicbrainzFacade::ArtistCreditTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup
    reflections_factory = IngestionReflections::Factory.new
    @factory = MusicbrainzFacade::Factory.new(@order, reflections_factory)
    @facade = MusicbrainzFacade::ArtistCredit.new(@factory, options)
  end

  test "#name" do
    assert_equal "Jello Biafra With NoMeansNo", @facade.name
  end

  test "#participants" do
    assert_equal 2, @facade.participants.length

    assert_equal "Biafra, Jello", @facade.participants.first.participant.scrape(:sort_name)
    assert_equal "Jello Biafra", @facade.participants.first.participant.scrape(:name)
    assert_equal "NoMeansNo", @facade.participants.second.participant.scrape(:sort_name)
  end

  def options
    Ingestion::Json.parse(json_string)[:artist_credit]
  end

  def json_string
    code = "36ddebf6-7fb2-4dc4-8931-aca5a3a35a30" # The Sky Is Falling and I Want My Mommy
    @json_string ||= Retrieve::Musicbrainz.new.call(:release, code, %w[artists artist-rels labels media recordings release-groups url-rels])
  end
end
