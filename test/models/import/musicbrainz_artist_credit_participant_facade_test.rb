require "test_helper"
require "minitest/mock"
require "support/shared_import_facade_tests"

class Import::MusicbrainzArtistCreditParticipantFacadeTest < ActiveSupport::TestCase
  include SharedImportFacadeTests

  TestArtist = Data.define(:id)
  def setup
    @data = Minitest::Mock.new
    @session = Minitest::Mock.new
    @subject = Import::MusicbrainzArtistCreditParticipantFacade.new(@session, data: @data)
  end

  test "#join_phrase" do
    @data.expect :joinphrase, " With "

    assert_equal " With ", @subject.join_phrase

    @data.verify
  end

  test "#participant" do
    # https://stackoverflow.com/questions/43494606/minitest-mock-expect-keyword-arguments
    @session.expect :build_facade, :fake_facade do |code:|
      true
    end

    @data.expect :artist, TestArtist.new(id: "123")

    assert_equal :fake_facade, @subject.participant

    @data.verify
    @session.verify
  end
end
