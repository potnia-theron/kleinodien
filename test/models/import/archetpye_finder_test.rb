require "test_helper"
require "support/shared_null_finder_tests"

class Import::ArchetypeFinderTest < ActiveSupport::TestCase
  include SharedNullFinderTests

  setup do
    @finder_class = Import::ArchetypeFinder
  end
end
