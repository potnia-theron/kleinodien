module SharedImportFindTests
  def test_when_no_entry_can_be_found
    assert_not cannot_find.call
  end
end
