require "test_helper"
require "minitest/mock"
require "support/shared_import_facade_tests"

class Import::MusicbrainzArtistCreditParticipantFacadeTest < ActiveSupport::TestCase
  include SharedImportFacadeTests

  def setup
    @subject = Import::MusicbrainzArtistCreditParticipantFacade.new(:fake_session, data: {})
  end
end
