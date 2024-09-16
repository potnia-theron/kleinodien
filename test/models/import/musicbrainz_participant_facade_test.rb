require "test_helper"
require "minitest/mock"
require "support/shared_import_facade_tests"

class Import::MusicbrainzParticipantFacadeTest < ActiveSupport::TestCase
  include SharedImportFacadeTests

  LiveSpan = Data.define(:begin, :end)

  setup do
    @subject = Import::MusicbrainzParticipantFacade.new(:fake_session, {})
  end

  test "#name" do
    data = {name: "Suffocation"}
    facade = Import::MusicbrainzParticipantFacade.new(:fake_session, {data: data})

    assert_equal "Suffocation", facade.name
  end

  test "data accessors" do
    messages_expected = {
      name: "Suffocation",
      sort_name: "Suffocation, The",
      disambiguation: "New York Death Metal"
    }

    messages_expected.each do |message, expected|
      data = {message => expected}
      facade = Import::MusicbrainzParticipantFacade.new(:fake_session, data: data)

      assert_equal expected, facade.send(message)
    end
  end

  test "#begins_at" do
    data = {life_span: {begin: "2024-03-25", end: nil}}
    facade = Import::MusicbrainzParticipantFacade.new(:fake_session, {data: data})

    assert_equal IncompleteDate.new(Date.new(2024, 3, 25), :day), facade.begins_at
  end

  test "ends_at" do
    data = {life_span: {begin: nil, end: "2024-03-26"}}
    facade = Import::MusicbrainzParticipantFacade.new(:fake_session, {data: data})

    assert_equal IncompleteDate.new(Date.new(2024, 3, 26), :day), facade.ends_at
  end
end
