require "test_helper"
require "support/shared_null_finder_tests"

class RecordFinder::ArchetypeTest < ActiveSupport::TestCase
  include SharedNullFinderTests

  setup do
    @finder = RecordFinder::Archetype.new
    @facade = Minitest::Mock.new
  end
end
