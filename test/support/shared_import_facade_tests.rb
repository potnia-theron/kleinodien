module SharedImportFacadeTests
  def test_model_class
    assert_kind_of ActiveRecord::Base, @subject.model_class.new
  end

  def test_session
    assert_respond_to @subject, :session
  end

  def test_options
    assert_respond_to @subject, :options
  end
end
