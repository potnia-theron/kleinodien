require "test_helper"
require "support/shared_import_properties_tests"

class Import::ArtistCreditParticipantPropertiesTest < ActiveSupport::TestCase
  include SharedImportPropertiesTests

  setup do
    @subject = Import::ArtistCreditParticipantProperties.new
  end

  test "#belongs_to_associations" do
    assert_equal 2, @subject.belongs_to_associations.length
    assert_equal @subject.belongs_to_associations.map(&:name).sort, [:artist_credit, :participant]
  end

  test "#has_many_associations" do
    assert_empty @subject.has_many_associations
  end

  test "#has_and_belongs_to_many_associations" do
    assert_empty @subject.has_and_belongs_to_many_associations
  end
end
