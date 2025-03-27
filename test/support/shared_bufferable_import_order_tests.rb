module SharedBufferableImportOrderTests
  def test_illegal_transition_from_open_to_persisting
    assert_equal "open", @subject.state

    @subject.save!
    @subject.buffering!
    assert_raises(RuntimeError) { @subject.done! }
  end

  def test_setting_all_good_states_via_bang_method
    assert_equal "open", @subject.state

    @subject.buffering!
    @subject.persisting!
    @subject.done!

    assert_equal "done", @subject.state
  end

  def test_setting_all_good_states_via_state_method
    assert_equal "open", @subject.state

    @subject.state = :buffering
    @subject.save!

    @subject.state = :persisting
    @subject.save!

    @subject.state = :done
    @subject.save!

    assert_equal "done", @subject.state
  end
end
