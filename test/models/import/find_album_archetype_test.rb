require "test_helper"
require "support/shared_import_find_tests"

class Import::FindAlbumArchetypeTest < ActiveSupport::TestCase
  include SharedImportFindTests

  setup do
    @session = Object.new
    @facade = Object.new
  end

  def cannot_find
    Import::FindAlbumArchetype.new(@session, facade: @facade)
  end
end
