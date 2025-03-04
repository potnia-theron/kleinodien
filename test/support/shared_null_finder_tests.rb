module SharedNullFinderTests
  def test_calling_the_finder_returns_nil
    assert_nil @finder_class.call
  end
end
