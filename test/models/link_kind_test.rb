require "test_helper"

class LinkKindTest < ActiveSupport::TestCase
  setup do
    @subject = LinkKind.new(name: "some link kind")
  end

  test "#name must be set" do
    @subject.name = nil
    assert @subject.invalid?
    assert_equal 1, @subject.errors.count
    assert_equal :blank, @subject.errors.first.type
  end

  test "#name must be unique" do
    @subject.name = link_kinds(:one).name
    assert @subject.invalid?
    assert_equal 1, @subject.errors.count
    assert_equal :taken, @subject.errors.first.type
  end
end
