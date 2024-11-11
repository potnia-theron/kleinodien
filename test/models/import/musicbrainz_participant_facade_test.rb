require "test_helper"
require "minitest/mock"
require "support/shared_import_facade_tests"
require "support/web_mock_external_apis"

class Import::MusicbrainzParticipantFacadeTest < ActiveSupport::TestCase
  include SharedImportFacadeTests

  LiveSpan = Data.define(:begin, :end)

  setup do
    WebMockExternalApis.setup

    code = "66c662b6-6e2f-4930-8610-912e24c63ed1"
    import_order = Minitest::Mock.new
    import_order.expect :kind, :participant
    import_order.expect :code, code
    @session = Import::MusicbrainzSession.new(import_order)
    @subject = Import::MusicbrainzParticipantFacade.new(@session, code: code)
  end

  test "name accessors" do
    assert_equal "AC/DC", @subject.name
    assert_equal "AC/DC", @subject.sort_name
    assert_equal "Australian hard rock band", @subject.disambiguation
  end

  test "#begins_at" do
    expected_date = IncompleteDate.new(Date.new(1973, 12, 31), :day)

    assert_equal expected_date, @subject.begins_at
  end

  test "ends_at" do
    assert_nil @subject.ends_at
  end
end
