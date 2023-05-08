# require "test_helper"

module SharedImportOrderTests
  def test_import_order_is_valid
    assert_predicate(@subject, :valid?)
  end

  def test_without_a_code_it_is_not_valid
    @subject.code = nil

    assert_not @subject.valid?
  end

  def test_without_a_kind_it_is_not_valid
    @subject.kind = nil

    assert_not @subject.valid?
  end

  def test_without_a_state_it_is_not_valid
    @subject.state = nil

    assert_not @subject.valid?
  end

  def test_with_an_illegal_state
    assert_raises(ArgumentError) { @subject.state = :illegal_state }
  end

  def test_with_an_invalid_uri
    import_order = @subject.class.new(uri: "ftp://example.com/this/is/not/a/love/song")

    assert_not_predicate import_order, :valid?
    assert_nil import_order.kind
    assert_nil import_order.code
  end

  def test_without_a_user_it_is_not_valid
    @subject.user = nil

    assert_not @subject.valid?
  end
end
