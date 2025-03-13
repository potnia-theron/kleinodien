require "test_helper"
# require "minitest/mock"
require "support/retrieve"
require "support/retrieve/musicbrainz"

class Import::MusicbrainzEditionPositionFacadeTest < ActiveSupport::TestCase
  test "scrape values" do
    options = {
      number: "one",
      position: 1,
      recording: {video: false}
    }

    facade = Import::MusicbrainzEditionPositionFacade.new(:fake, options)
    assert_equal "one", facade.scrape(:alphanumeric)
    assert_equal 1, facade.scrape(:no)
    assert_equal "SongEdition", facade.delegated_type_for(nil)
  end

  test "#delegated_type_for" do
    options = {recording: {video: true}}

    facade = Import::MusicbrainzEditionPositionFacade.new(:fake, options)
    assert_raises(RuntimeError) { facade.delegated_type_for(nil) }
  end
end
