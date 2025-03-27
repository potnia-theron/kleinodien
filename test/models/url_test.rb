require "test_helper"
require "support/shared_centralable_tests"
require "support/shared_linkable_tests"

class UrlTest < ActiveSupport::TestCase
  include SharedCentralableTests
  include SharedLinkableTests

  setup do
    @subject = Url.new(address: "https://example.com")
  end

  test "#address can't be nil" do
    @subject.address = nil
    assert @subject.invalid?
    assert_equal 1, @subject.errors.count
    assert_equal :blank, @subject.errors.first.type
  end

  test "#address must be unique" do
    @subject.address = urls(:one).address
    assert @subject.invalid?
    assert_equal 1, @subject.errors.count
    assert_equal :taken, @subject.errors.first.type
  end
end
