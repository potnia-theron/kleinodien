module SharedCentralableTests
  def test_subject_has_one_associated_central_after_being_saved
    assert_nil @subject.central

    @subject.save!

    assert_instance_of Central, @subject.central
    assert_not_predicate @subject.central, :new_record?
  end
end
