require "test_helper"
require "shared_periodeable_tests"

class ParticipantTest < ActiveSupport::TestCase
  include SharedPeriodeableTests

  setup do
    @subject = Participant.new(name: "Rock star")
  end

  test "with valid attributes" do
    assert_predicate @subject, :valid?
  end

  test "not valid without a name" do
    @subject.name = nil

    assert_not_predicate @subject, :valid?
  end

  test "set #sort_name unless present" do
    assert_predicate @subject, :valid?
    assert_equal "Rock star", @subject.sort_name
  end

  test "leave #sort_name untouched when set" do
    @subject.name = "Some"
    @subject.sort_name = "One"

    assert_predicate @subject, :valid?
    assert_equal "Some", @subject.name
    assert_equal "One", @subject.sort_name
  end

  test "#name must be unique" do
    @subject.save!

    participant = Participant.new(name: @subject.name)

    assert_not_predicate participant, :valid?
    assert_raises(ActiveRecord::RecordInvalid) { participant.save!(name: "Rock star") }
  end
end
