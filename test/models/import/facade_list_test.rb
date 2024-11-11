require "test_helper"
require "minitest/mock"

class Import::FacadeListTest < ActiveSupport::TestCase
  # OPTIMIZE: test forwarding of options on #to_collectors and #to_persisters
  setup do
    @session = Minitest::Mock.new
    @f_mocks = 2.times.map { |idx| mock_facade(idx) }

    @facade_list = Import::FacadeList.new(@session, data: @f_mocks, model: Object)
  end

  test "#each" do
    enumerator = @facade_list.each
    assert_instance_of Object, enumerator.next
    assert_instance_of Object, enumerator.next

    @session.verify
  end

  test "#map" do
    facades = @facade_list.map { |item| item.class }

    @f_mocks.each do |f_mock|
    end
    assert_equal facades.length, 2
    assert_equal facades.count { |klass| klass == Object }, 2

    @session.verify
  end

  test "#to_collectors" do
    @session.expect :build_collect_action, :collector_0, [], facade: @f_mocks[0]
    @session.expect :build_collect_action, :collector_1, [], facade: @f_mocks[1]

    collectors = @facade_list.to_collectors

    assert_equal collectors, [:collector_0, :collector_1]

    @session.verify
  end

  test "#to_persisters" do
    @session.expect :build_create_action, :persister_0, [], facade: @f_mocks[0]
    @session.expect :build_create_action, :persister_1, [], facade: @f_mocks[1]

    persisters = @facade_list.to_persisters

    assert_equal persisters.length, 2
    assert_equal persisters, [:persister_0, :persister_1]

    @session.verify
  end

  def mock_facade(idx)
    facade = Object.new
    @session.expect :build_facade, facade do |consecutive_number: idx, data: idx, model: Object|
      true
    end

    facade
  end
end
