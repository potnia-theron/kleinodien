require "test_helper"
require "support/shared_centralable_tests"
require "support/shared_linkable_tests"

class UrlTest < ActiveSupport::TestCase
  include SharedCentralableTests
  include SharedLinkableTests

  setup do
    @subject = Url.new(address: "https://example.com")
  end

  test "#address must be set" do
    @subject.address = nil
    assert @subject.invalid?
  end
end
