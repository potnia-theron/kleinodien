require "test_helper"

class Import::ArtistCreditPropertiesTest < ActiveSupport::TestCase
  setup do
    @properties = Import::ArtistCreditProperties.new
  end

  test "#belongs_to_associations" do
    assert_equal @properties.belongs_to_associations, []
  end

  test "#has_many_associations" do
    assert_equal @properties.has_many_associations.map(&:name), [:participants]
  end

  test "#has_and_belongs_to_many_associations" do
    assert_equal @properties.has_and_belongs_to_many_associations, []
  end
end
