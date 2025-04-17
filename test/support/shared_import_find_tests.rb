module SharedImportFindTests
  extend ActiveSupport::Testing::Declarative  

  test "when no entry can be found" do
    assert_not cannot_find.call
  end
end
