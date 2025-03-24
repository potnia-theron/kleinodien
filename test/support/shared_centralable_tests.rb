module SharedCentralableTests
  extend ActiveSupport::Testing::Declarative

  test "subject_has_one_associated_central" do
    central = @subject.central
    assert_instance_of Central, central
    assert_predicate central, :new_record?

    @subject.save!

    assert_instance_of Central, @subject.central
    assert_not_predicate @subject.central, :new_record?
    assert_not_predicate central, :new_record?
  end
end
