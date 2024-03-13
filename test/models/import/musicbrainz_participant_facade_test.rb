require "test_helper"
require "support/shared_import_facade_tests"

class Import::MusicbrainzParticipantFacadeTest < ActiveSupport::TestCase
  include SharedImportFacadeTests

  setup do
    @subject = Import::MusicbrainzParticipantFacade.new(:fake_session, {})
  end
end
