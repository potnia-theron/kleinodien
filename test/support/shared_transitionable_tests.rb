module SharedTransitionableTests
  def test_respond_to_state
    assert_respond_to @subject, :state=
  end

  def test_with_an_illegal_state
    assert_raises(ArgumentError) { @subject.state = :illegal_state }
  end

  def test_state_set_to_failed_more_than_one_time
    assert_not_equal "failed", @subject.state

    3.times { @subject.failed! }

    assert_equal "failed", @subject.state
  end
end
