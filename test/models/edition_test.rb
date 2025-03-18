require "test_helper"
require "support/shared_centralable_tests"

class EditionTest < ActiveSupport::TestCase
  include SharedCentralableTests

  setup do
    archetype = Archetype.new(title: "a title", archetypeable: SongArchetype.new)
    @subject = Edition.new(archetype: archetype, editionable: SongEdition.new)
  end
end
