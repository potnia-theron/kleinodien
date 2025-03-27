require "test_helper"
require "support/shared_centralable_tests"
require "support/shared_linkable_tests"

class ArchetypeTest < ActiveSupport::TestCase
  include SharedCentralableTests
  include SharedLinkableTests

  setup do
    @subject = Archetype.new(title: "a title", archetypeable: SongArchetype.new)
  end
end
