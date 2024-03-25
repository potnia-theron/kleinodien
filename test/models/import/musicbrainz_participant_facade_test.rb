require "test_helper"
require "minitest/mock"
require "support/shared_import_facade_tests"

class Import::MusicbrainzParticipantFacadeTest < ActiveSupport::TestCase
  include SharedImportFacadeTests

  setup do
    @data = Minitest::Mock.new
    @subject = Import::MusicbrainzParticipantFacade.new(:fake_session, {data: @data})
  end

  test "#name" do
    @data.expect :name, "Suffocation"

    assert_equal "Suffocation", @subject.name

    @data.verify
  end

  test "data accessors" do
    messages_expected = {
      name: "Suffocation",
      sort_name: "Suffocation, The",
      disambiguation: "New York Death Metal"
    }

    messages_expected.each do |message, expected|
      @data.expect message, expected

      assert_equal expected, @subject.send(message)

      @data.verify
    end
  end

  test "#begin_date" do
    @data.expect :begin_date, "2024-03-25"

    assert_equal IncompleteDate.new(Date.new(2024, 3, 25), :day), @subject.begin_date
  end
end
