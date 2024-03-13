module SharedImportPropertiesTests
  def test_model_class
    assert_kind_of ActiveRecord::Base, @subject.model_class.new
  end

  def test_belongs_to_associations
    assert_kind_of Array, @subject.belongs_to_associations
  end

  def has_many_associations
    assert_kind_of Array, @subject.has_many_associations
  end

  def has_and_belongs_to_many_associations
    assert_kind_of Array, @subject.has_and_belongs_to_many_associations
  end
end
