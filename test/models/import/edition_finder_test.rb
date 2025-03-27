require "test_helper"
require "support/shared_null_finder_tests"

class Import::EditionFinderTest < ActiveSupport::TestCase
  include SharedNullFinderTests

  setup do
    @finder_class = Import::EditionFinder
  end
end
