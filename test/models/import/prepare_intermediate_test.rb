require "test_helper"
require "minitest/mock"

class Import::PrepareIntermediateTest < ActiveSupport::TestCase
  setup do
    @model_class = Minitest::Mock.new

    @intermediate = Minitest::Mock.new
    @intermediate.expect :code_column_name, :fake_code
    @intermediate.expect :code, 123

    @prepare_intermediate = Import::PrepareIntermediate.new(@intermediate)
  end

  test "#prepare!" do
    @intermediate.expect :model_class, @model_class
    @model_class.expect :where, [], fake_code: 123

    @intermediate.expect :model_class, @model_class
    @intermediate.expect :codes_hash, {fake_code: 123, other_code: 777}
    @model_class.expect :where, [], [{fake_code: 123, other_code: 777}]

    assert_not @prepare_intermediate.prepare!

    @intermediate.verify
    @model_class.verify
  end
end
