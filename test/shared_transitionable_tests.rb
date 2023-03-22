module SharedTransitionableTests
  def test_respond_to_state
    assert_respond_to @subject, :state=
  end

  def test_respond_to_can_change_state_to?
    assert_respond_to @subject, :can_change_state_to?
  end

  def test_with_an_illegal_state
    assert_raises(ArgumentError) { @subject.state = :illegal_state }
  end
end
