require "test_helper"
require "support/shared_centralable_tests"
require "support/shared_linkable_tests"

class EditionTest < ActiveSupport::TestCase
  include SharedCentralableTests
  include SharedLinkableTests

  setup do
    archetype = Archetype.new(title: "a title", archetypeable: SongArchetype.new)
    @subject = Edition.new(archetype: archetype, editionable: SongEdition.new)
  end

  test "link to participants" do
    participant = Participant.new(name: "a name")

    link = Link.new(source: @subject.central, destination: participant.central, link_kind: link_kinds(:one))

    @subject.save!

    assert_not_predicate link, :new_record?
  end
end
