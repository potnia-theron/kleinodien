require "test_helper"
require "minitest/mock"
require "support/shared_import_facade_tests"

class Import::MusicbrainzArtistCreditParticipantFacadeTest < ActiveSupport::TestCase
  include SharedImportFacadeTests

  def setup
    @session = Minitest::Mock.new
    @subject = Import::MusicbrainzArtistCreditParticipantFacade.new(@session, data: {})
  end

  test "#join_phrase" do
    facade = Import::MusicbrainzArtistCreditParticipantFacade.new(
      @session, data: [{joinphrase: " With "}]
    )

    assert_equal " With ", facade.join_phrase
  end

  test "#participant" do
    session = Minitest::Mock.new
    session.expect :build_facade, :fake_facade do |code:|
      true
    end

    data = [{artist: {id: "123"}}]
    facade = Import::MusicbrainzArtistCreditParticipantFacade.new(session, data: data)

    assert_equal :fake_facade, facade.participant_facade
  end
end
