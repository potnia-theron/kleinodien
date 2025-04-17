module SharedImportOrderTests
  extend ActiveSupport::Testing::Declarative

  test "import order is valid" do
    assert_predicate(@subject, :valid?)
  end

  test "without a code it is not valid" do
    @subject.code = nil

    assert_not @subject.valid?
  end

  test "without a kind it is not valid" do
    @subject.kind = nil

    assert_not @subject.valid?
  end

  test "state can not be nil" do
    assert_raises(RuntimeError) { @subject.state = nil }
  end

  test "with an illegal state" do
    assert_raises(ArgumentError) { @subject.state = :illegal_state }
  end

  test "with an invalid uri" do
    import_order = @subject.class.new(uri: "ftp://example.com/this/is/not/a/love/song")

    assert_not_predicate import_order, :valid?
    assert_nil import_order.kind
    assert_nil import_order.code
  end
end
