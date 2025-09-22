module SharedNullFinderTests
  extend ActiveSupport::Testing::Declarative

  test "calling the finder returns nil" do
    assert_nil @finder.call(@facade)
  end
end
