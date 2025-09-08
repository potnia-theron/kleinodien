require "test_helper"
require "support/shared_null_finder_tests"

class IngestionFinder::EditionTest < ActiveSupport::TestCase
  include SharedNullFinderTests

  setup do
    @finder_class = IngestionFinder::Edition
  end
end
