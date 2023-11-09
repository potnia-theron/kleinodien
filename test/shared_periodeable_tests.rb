module SharedPeriodeableTests
  def valid_accuracies
    %i[year month day]
  end

  def test_valid_begin_date_accuracies
    valid_accuracies.each do |accuracy|
      @subject.begin_date_accuracy = accuracy

      assert_predicate(@subject, "begin_date_accuracy_#{accuracy}?")
    end
  end

  def test_valid_end_date_accuracies
    valid_accuracies.each do |accuracy|
      @subject.end_date_accuracy = accuracy

      assert_predicate(@subject, "end_date_accuracy_#{accuracy}?")
    end
  end

  def test_with_invalid_accuracies
    assert_raises(ArgumentError) { @subject.begin_date_accuracy = :blue_book }
    assert_raises(ArgumentError) { @subject.end_date_accuracy = :golden_pineapple }
  end

  def test_begins_at_without_any_data
    begins_at = @subject.begins_at

    assert_nil begins_at.year
    assert_nil begins_at.month
    assert_nil begins_at.day
  end

  def test_ends_at_without_any_data
    ends_at = @subject.ends_at

    assert_nil ends_at.year
    assert_nil ends_at.month
    assert_nil ends_at.day
  end

  def test_begins_at_with_valid_data
    @subject.begin_date = "2023-11-07"
    @subject.begin_date_accuracy = "day"
    begins_at = @subject.begins_at

    assert_equal 2023, begins_at.year
    assert_equal 11, begins_at.month
    assert_equal 7, begins_at.day
  end

  def test_ends_at_with_valid_data
    @subject.end_date = Date.new(2023, 11, 7)
    @subject.end_date_accuracy = "day"
    ends_at = @subject.ends_at

    assert_equal 2023, ends_at.year
    assert_equal 11, ends_at.month
    assert_equal 7, ends_at.day
  end

  def test_begin_with_date_but_without_accuracy
    @subject.begin_date = Time.zone.today
    @subject.begin_date_accuracy = nil

    assert_not_predicate @subject, :valid?
  end

  def test_begin_with_accuracy_but_without_date
    @subject.begin_date = nil
    @subject.begin_date_accuracy = :day

    assert_not_predicate @subject, :valid?
  end

  def test_end_with_date_but_without_accuracy
    @subject.end_date = Time.zone.today
    @subject.end_date_accuracy = nil

    assert_not_predicate @subject, :valid?
  end

  def test_end_with_accuracy_but_without_date
    @subject.end_date = nil
    @subject.end_date_accuracy = :day

    assert_not_predicate @subject, :valid?
  end
end
