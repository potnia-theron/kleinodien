require "test_helper"
require "minitest/mock"

class WhereAndOrTest < ActiveSupport::TestCase
  setup do
    @model_class = Minitest::Mock.new
    @model_class.expect :constantize, @model_class
  end

  test "#and" do
    where_and_or = WhereAndOr.new(@model_class, this: 123, that: 321)
    @model_class.expect :where, :result, [["this = ? AND that = ?", 123, 321]]

    assert_equal where_and_or.and, :result
  end

  test "#or" do
    where_and_or = WhereAndOr.new(@model_class, {this: 123, that: 321})
    @model_class.expect :where, :result, [["this = ? OR that = ?", 123, 321]]

    assert_equal where_and_or.or, :result
  end

  test ".and" do
    @model_class.expect :where, :result, [["this = ? AND that = ?", 123, 321]]

    assert_equal WhereAndOr.and(@model_class, this: 123, that: 321), :result
  end

  test ".or" do
    where_and_or = WhereAndOr.new(@model_class, this: 123, that: 321)
    @model_class.expect :where, :result, [["this = ? OR that = ?", 123, 321]]

    assert_equal where_and_or.or, :result
  end
end
