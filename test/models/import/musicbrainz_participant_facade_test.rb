require "test_helper"
require "minitest/mock"
# require "support/web_mock_external_apis"

class Import::MusicbrainzParticipantFacadeTest < ActiveSupport::TestCase
  setup do
    @musicbrainz_code = "bdd93dec-7089-4100-9cfb-6a3bcb5aff20"
    @facade_layer = Minitest::Mock.new
    @options = {id: @musicbrainz_code}

    @subject = Import::MusicbrainzParticipantFacade.new(@facade_layer, @options)
  end

  test "#all_codes" do
    assert_respond_to @subject, :all_codes
  end

  test "#cheap_codes" do
    assert_respond_to @subject, :cheap_codes
  end
end
