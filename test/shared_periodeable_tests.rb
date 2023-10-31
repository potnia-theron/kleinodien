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
end
