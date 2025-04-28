require "test_helper"
require "support/shared_bufferable_import_order_tests"
require "support/shared_transitionable_tests"

class MusicbrainzImportOrderTest < ActiveSupport::TestCase
  include SharedBufferableImportOrderTests
  include SharedTransitionableTests

  setup do
    @subject = MusicbrainzImportOrder.new(kind: "release", code: "073a15b4-1940-4f1e-9234-6a1701a4ce28")
  end

  test "is not valid without kind" do
    @subject.kind = nil
    assert @subject.invalid?
  end

  test "is not valid without code" do
    @subject.code = nil
    assert @subject.invalid?
  end
end
