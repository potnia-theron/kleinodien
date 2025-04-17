module SharedBufferableImportOrderTests
  extend ActiveSupport::Testing::Declarative

  test "illegal transition from open to persisting" do
    assert_equal "open", @subject.state

    @subject.save!
    @subject.buffering!
    assert_raises(RuntimeError) { @subject.done! }
  end

  test "setting all good states via bang method" do
    assert_equal "open", @subject.state

    @subject.buffering!
    @subject.persisting!
    @subject.done!

    assert_equal "done", @subject.state
  end

  test "setting all good states via state method" do
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
