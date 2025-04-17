module SharedPeriodableTests
  extend ActiveSupport::Testing::Declarative

  def valid_accuracies
    %i[year month day]
  end

  test "valid begin date accuracies" do
    valid_accuracies.each do |accuracy|
      @subject.begin_date_accuracy = accuracy

      assert_predicate(@subject, "begin_date_accuracy_#{accuracy}?")
    end
  end

  test "valid end date accuracies" do
    valid_accuracies.each do |accuracy|
      @subject.end_date_accuracy = accuracy

      assert_predicate(@subject, "end_date_accuracy_#{accuracy}?")
    end
  end

  test "with invalid accuracies" do
    assert_raises(ArgumentError) { @subject.begin_date_accuracy = :blue_book }
    assert_raises(ArgumentError) { @subject.end_date_accuracy = :golden_pineapple }
  end

  test "begins at without any data" do
    begins_at = @subject.begins_at

    assert_nil begins_at.year
    assert_nil begins_at.month
    assert_nil begins_at.day
  end

  test "ends at without any data" do
    ends_at = @subject.ends_at

    assert_nil ends_at.year
    assert_nil ends_at.month
    assert_nil ends_at.day
  end

  test "begins at with valid data" do
    @subject.begin_date = "2023-11-07"
    @subject.begin_date_accuracy = "day"
    begins_at = @subject.begins_at

    assert_equal 2023, begins_at.year
    assert_equal 11, begins_at.month
    assert_equal 7, begins_at.day
  end

  test "ends at with valid data" do
    @subject.end_date = Date.new(2023, 11, 7)
    @subject.end_date_accuracy = "day"
    ends_at = @subject.ends_at

    assert_equal 2023, ends_at.year
    assert_equal 11, ends_at.month
    assert_equal 7, ends_at.day
  end

  test "begin with date but without accuracy" do
    @subject.begin_date = Time.zone.today
    @subject.begin_date_accuracy = nil

    assert_not_predicate @subject, :valid?
  end

  test "begin with accuracy but without date" do
    @subject.begin_date = nil
    @subject.begin_date_accuracy = :day

    assert_not_predicate @subject, :valid?
  end

  test "end with date but without accuracy" do
    @subject.end_date = Time.zone.today
    @subject.end_date_accuracy = nil

    assert_not_predicate @subject, :valid?
  end

  test "end with accuracy but without date" do
    @subject.end_date = nil
    @subject.end_date_accuracy = :day

    assert_not_predicate @subject, :valid?
  end
end
