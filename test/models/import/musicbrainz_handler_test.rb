require "test_helper"
require "minitest/mock"

class Import::MusicbrainzTestMockFacade
  def initialize(...)
  end
end

class MockCall
  def initialize(return_value: nil)
    @return_value = return_value
  end

  def call = @return_value
end

class Import::MusicbrainzHandlerTest < ActiveSupport::TestCase
  test "foobar" do
    import_order = Minitest::Mock.new
    handler = Import::MusicbrainzHandler.new(import_order)
    import_order.expect :kind, "test_mock"
    import_order.expect :kind, "test_mock"

    import_order.expect :code, "9138acfc-7bed-11ef-b718-c33088555133"
    import_order.expect :code, "9138acfc-7bed-11ef-b718-c33088555133"

    session = Minitest::Mock.new
    session.expect :build_collection_igniter, proc {}, [Import::MusicbrainzTestMockFacade]
    session.expect :lock, nil
    session.expect :build_creation_igniter, proc { :success }, [Import::MusicbrainzTestMockFacade]

    handler.stub :session, session do
      assert_equal :success, handler.call
    end

    import_order.verify
    session.verify
  end
end
