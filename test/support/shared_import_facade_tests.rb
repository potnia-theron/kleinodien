module SharedImportFacadeTests
  extend ActiveSupport::Testing::Declarative

  test "model_class" do
    assert_kind_of ActiveRecord::Base, @subject.model_class.new
  end

  test "session" do
    assert_respond_to @subject, :session
  end

  test "options" do
    assert_respond_to @subject, :options
  end
end
