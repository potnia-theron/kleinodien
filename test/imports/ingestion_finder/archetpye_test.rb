require "test_helper"
require "support/shared_null_finder_tests"

class IngestionFinder::ArchetypeTest < ActiveSupport::TestCase
  include SharedNullFinderTests

  setup do
    @finder = IngestionFinder::Archetype.new
    @facade = Minitest::Mock.new
  end
end
