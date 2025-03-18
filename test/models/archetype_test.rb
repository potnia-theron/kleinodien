require "test_helper"
require "support/shared_centralable_tests"

class ArchetypeTest < ActiveSupport::TestCase
  include SharedCentralableTests

  setup do
    @subject = Archetype.new(title: "a title", archetypeable: SongArchetype.new)
  end
end
