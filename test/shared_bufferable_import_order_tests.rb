module SharedBufferableImportOrderTests
  def test_illegal_transition_from_open_to_persisting
    assert_equal @subject.state, "open"

    assert_raises(RuntimeError) { @subject.persisting! }
  end
end
