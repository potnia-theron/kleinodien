require "test_helper"
require "support/shared_null_finder_tests"

class IngestionFinder::ArchetypeTest < ActiveSupport::TestCase
  include SharedNullFinderTests

  setup do
    @finder_class = IngestionFinder::Archetype
  end
end
