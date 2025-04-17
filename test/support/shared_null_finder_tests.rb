module SharedNullFinderTests
  extend ActiveSupport::Testing::Declarative

  test "calling the finder returns nil" do
    assert_nil @finder_class.call
  end
end
