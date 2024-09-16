require "test_helper"
require "minitest/mock"
require "support/shared_import_facade_tests"

class Import::MusicbrainzArtistCreditFacadeTest < ActiveSupport::TestCase
  include SharedImportFacadeTests

  setup do
    @data = []
    @subject = Import::MusicbrainzArtistCreditFacade.new(:fake_session, data: @data)
  end

  test "#name with valid data" do
    @data.push({name: "Diana", joinphrase: " feat. "}, {name: "Artemis"})

    assert_equal "Diana feat. Artemis", @subject.name
  end

  test "joinphrase in last name" do
    @data.push({name: "Artemis"}, {name: "Diana", joinphrase: " feat. "})

    assert_raises(RuntimeError) { @subject.name }
  end
end
