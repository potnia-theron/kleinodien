require "test_helper"
require "minitest/mock"

class Import::IntermediateTest < ActiveSupport::TestCase
  setup do
    @adapter = Minitest::Mock.new
    @model_class = Minitest::Mock.new
    # @model_class.expect :instance_of?, false, [Class]
    # @model_class.expect :constantize, @model_class

    @intermediate = Import::Intermediate.new(adapter: @adapter, model_class: @model_class)
  end

  test "#prepare! when the record is not already in the database" do
    @adapter.expect :cheap_search_parameters, {fake_code: 123}
    @adapter.expect :expensive_search_parameters, {fake_code: 123, other_code: 345}

    @model_class.expect :where, [], [{fake_code: 123}]
    @model_class.expect :where, [], [{fake_code: 123, other_code: 345}]

    @intermediate.prepare!

    assert_nil @intermediate.id

    @adapter.verify
    @model_class.verify
  end

  test "#prepare! when a persited record can be found at the first try" do
    @adapter.expect :cheap_search_parameters, {fake_code: 123}

    record = Minitest::Mock.new
    record.expect :id, 333
    @model_class.expect :where, [record], [{fake_code: 123}]

    @intermediate.prepare!
    assert_equal @intermediate.id, 333

    @adapter.verify
    @model_class.verify
    record.verify
  end

  test "#prepare! when a persited record can be found at the second try" do
    @adapter.expect :cheap_search_parameters, {fake_code: 123}
    @model_class.expect :where, [], [{fake_code: 123}]

    record = Minitest::Mock.new
    record.expect :id, 333
    @adapter.expect :expensive_search_parameters, {fake_code: 123, other_code: 345}
    @model_class.expect :where, [record], [{fake_code: 123, other_code: 345}]

    @intermediate.prepare!
    assert_equal @intermediate.id, 333

    @adapter.verify
    @model_class.verify
    record.verify
  end

  test "#prepare! when there are too many results" do
    @adapter.expect :cheap_search_parameters, {fake_code: 123}
    @adapter.expect :expensive_search_parameters, {fake_code: 123, other_code: 345}

    @model_class.expect :where, [], [{fake_code: 123}]
    @model_class.expect :where, [1, 2], [{fake_code: 123, other_code: 345}]

    assert_raises(RuntimeError) { @intermediate.prepare! }
    assert_nil @intermediate.id

    @adapter.verify
    @model_class.verify
  end
end
