require "test_helper"
# require "minitest/mock"
require "support/retrieve"
require "support/retrieve/musicbrainz"

class Import::MusicbrainzArtistCreditFacadeTest < ActiveSupport::TestCase
  setup do
    @facade = Import::MusicbrainzArtistCreditFacade.new(:fake, options)
  end

  test "#name" do
    assert_equal "Jello Biafra With NoMeansNo", @facade.name
  end

  test "#participants" do
    assert_equal 2, @facade.participants.length
    assert_equal "Biafra, Jello", @facade.participants.first.dig(:artist, :sort_name)
    assert_equal "NoMeansNo", @facade.participants.second.dig(:artist, :sort_name)
  end

  def options
    Import::Json.parse(json_string)[:artist_credit]
  end

  def json_string
    code = "36ddebf6-7fb2-4dc4-8931-aca5a3a35a30" # The Sky Is Falling and I Want My Mommy
    @json_string ||= Retrieve.musicbrainz(:release, code)
  end
end
