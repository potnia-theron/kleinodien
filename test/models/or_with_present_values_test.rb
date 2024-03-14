require "test_helper"

class OrWithPresentValuesTest < ActiveSupport::TestCase
  setup do
  end

  test "without any parameters" do
    assert_not OrWithPresentValues.query(attributes: {}, model_class: :fake_model_class)
  end

  test "with nil values" do
    attributes = {null: nil, nothing: nil}
    assert_not OrWithPresentValues.query(attributes: attributes, model_class: :fake_model_class)
  end

  test "with values" do
    Participant.create!(name: "test", sort_name: "test")
    attributes = {name: "test"}

    query = OrWithPresentValues.query(attributes: attributes, model_class: Participant)

    assert_kind_of ActiveRecord::Relation, query

    result = query.load
    assert_equal 1, result.length
    assert_equal result.first.name, "test"
  end
end
