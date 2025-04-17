module SharedTransitionableTests
  extend ActiveSupport::Testing::Declarative

  test "respond to state" do
    assert_respond_to @subject, :state=
  end

  test "with an illegal state" do
    assert_raises(ArgumentError) { @subject.state = :illegal_state }
  end

  test "state set to failed more than one time" do
    assert_not_equal "failed", @subject.state

    3.times { @subject.failed! }

    assert_equal "failed", @subject.state
  end
end
