require "test_helper"
require "minitest/mock"

class Import::CollectorTest < ActiveSupport::TestCase
  setup do
    @session = Minitest::Mock.new
    @finder = Minitest::Mock.new
    @facade = Minitest::Mock.new

    @session.expect :build_finder, @finder, [@facade]
    @collector = Import::Collector.new(@session, facade: @facade)
  end

  test "existing record is found" do
    @finder.expect :call, :gotcha
    assert_equal :gotcha, @collector.call
  end

  test "non existent record is buffered" do
    properties = Minitest::Mock.new
    @facade.expect :model_class, self.class
    @session.expect :build_properties, properties, [self.class]
    properties.expect :belongs_to_associations, []
    properties.expect :has_many_associations, []
    @finder.expect :call, nil

    assert_nil @collector.call

    properties.verify
  end

  teardown do
    @session.verify
    @finder.verify
    @facade.verify
  end
end
