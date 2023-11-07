require "test_helper"

class IncompleteDateTest < ActiveSupport::TestCase
  setup do
    @subject = IncompleteDate.new(Time.zone.today, :day)
  end

  def test_accessors
    assert_respond_to(@subject, :date)
    assert_respond_to(@subject, :accuracy)
  end

  def test_validation_on_valid_instance
    assert_predicate @subject, :valid?
  end

  def test_with_an_invalid_date
    @subject.date = "Wednesday"

    assert_not_predicate @subject, :valid?
  end

  def test_with_an_invalid_accuracy
    @subject.accuracy = "green"

    assert_not_predicate @subject, :valid?
  end

  def test_without_accuracy
    @subject.accuracy = nil

    assert_not_predicate @subject, :valid?
  end

  def test_without_date
    @subject.date = nil

    assert_not_predicate @subject, :valid?
  end

  def test_without_accuracy_and_without_date
    @subject.accuracy = nil
    @subject.date = nil

    assert_not_predicate @subject, :valid?
  end
end
