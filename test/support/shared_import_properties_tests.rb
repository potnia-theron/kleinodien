module SharedImportPropertiesTests
  extend ActiveSupport::Testing::Declarative

  test "model_class" do
    assert_kind_of ActiveRecord::Base, @subject.model_class.new
  end

  test "belongs_to_associations" do
    assert_kind_of Array, @subject.belongs_to_associations
  end

  test "has_many_associations" do
    assert_kind_of Array, @subject.has_many_associations
  end

  test "has_and_belongs_to_many_associations" do
    assert_kind_of Array, @subject.has_and_belongs_to_many_associations
  end
end
