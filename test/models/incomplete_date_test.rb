require "test_helper"

class IncompleteDateTest < ActiveSupport::TestCase
  setup do
    @today = Time.zone.today
  end

  def test_with_valid_arguments
    assert_instance_of IncompleteDate, IncompleteDate.new(@today, "month")
  end

  def test_with_an_invalid_date
    assert_raises(Date::Error) { IncompleteDate.new("Wednesday", :day) }
  end

  def test_with_valid_accuracies
    accuracies = %i[year month day].map { |accuracy| [accuracy, accuracy.to_sym] }
    accuracies.push [4, 6, 7]

    accuracies.flatten.each do |accuracy|
      ida = IncompleteDate.new(@today, accuracy)

      assert_equal accuracy, ida.accuracy
    end
  end

  def test_with_an_invalid_accuracy
    assert_raises(ArgumentError) { IncompleteDate.new(@today, "green") }
  end

  def test_with_date_as_string
    ida = IncompleteDate.new("2023-11-07", :year)

    assert_instance_of Date, ida.date
  end
end
