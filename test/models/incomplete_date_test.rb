require "test_helper"

class IncompleteDateTest < ActiveSupport::TestCase
  setup do
    @today = Time.zone.today
  end

  test ".from_string with complete string" do
    incoda = IncompleteDate.from_string(@today.to_s)

    assert_equal @today, incoda.date
    assert_equal :day, incoda.accuracy
  end

  test ".from_string with a yyyy-mm string" do
    incoda = IncompleteDate.from_string("2024-03")

    assert_equal Date.new(2024, 3, 1), incoda.date
    assert_equal :month, incoda.accuracy
  end

  test ".from_string with a yyyy string" do
    incoda = IncompleteDate.from_string("2024")

    assert_equal Date.new(2024, 1, 1), incoda.date
    assert_equal :year, incoda.accuracy
  end

  test ".from_string with invalid data" do
    [nil, "2024-04-05-06", "no date", "", " ", "3033-12-32"]
      .each { |bad| assert_raises { IncompleteDate.from_string(bad) } }
  end

  test "test_with_valid_arguments" do
    ida = IncompleteDate.new("2000-01-02", "month")

    assert_equal 2000, ida.year
    assert_equal 1, ida.month
    assert_equal 2, ida.day
  end

  test "test_with_an_invalid_date" do
    assert_raises(Date::Error) { IncompleteDate.new("Wednesday", :day) }
  end

  test "test_with_valid_accuracies" do
    accuracies = %i[year month day].map { |accuracy| [accuracy, accuracy.to_sym] }
    accuracies.push [4, 6, 7]

    accuracies.flatten.each do |accuracy|
      ida = IncompleteDate.new(@today, accuracy)

      assert_equal accuracy, ida.accuracy
    end
  end

  test "test_with_an_invalid_accuracy" do
    assert_raises(ArgumentError) { IncompleteDate.new(@today, "green") }
  end

  test "test_with_date_as_string" do
    ida = IncompleteDate.new("2023-11-07", :year)

    assert_instance_of Date, ida.date
  end

  test "<=>" do
    incoda = IncompleteDate.new(@today, :year)

    assert_equal IncompleteDate.new(@today, :year), incoda
    assert_equal IncompleteDate.new(@today, :day), incoda, "accuracy is ignored"
    assert_operator IncompleteDate.new(@today.next_week, :month), :>, incoda
  end
end
