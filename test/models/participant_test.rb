require "test_helper"
require "shared_periodeable_tests"

class ParticipantTest < ActiveSupport::TestCase
  include SharedPeriodeableTests
  setup do
    @subject = Participant.new
  end

  test "set #sort_name unless present" do
    @subject.name = "Rockstar"

    assert_predicate @subject, :valid?
    assert_equal "Rockstar", @subject.sort_name
  end
end
