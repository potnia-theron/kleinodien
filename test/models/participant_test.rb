require "test_helper"
require "shared_periodeable_tests"

class ParticipantTest < ActiveSupport::TestCase
  include SharedPeriodeableTests
  setup do
    @subject = Participant.new
  end
end
