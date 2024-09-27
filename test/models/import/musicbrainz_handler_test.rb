require "test_helper"
require "minitest/mock"

class Import::MusicbrainzHandlerTest < ActiveSupport::TestCase
  test "#call" do
    import_order = Minitest::Mock.new
    import_order.expect :buffering!, true
    import_order.expect :persisting!, true
    import_order.expect :done!, true

    facade = :fake_facade # Minitest::Mock.new

    session = Minitest::Mock.new
    session.expect :build_collection_igniter, proc {}, [facade]
    session.expect :lock, nil
    session.expect :build_creation_igniter, proc { :success }, [facade]

    handler = Import::MusicbrainzHandler.new(import_order)
    handler.define_singleton_method :session, proc { session }
    handler.define_singleton_method :facade, proc { facade }

    assert_equal :success, handler.call
    import_order.verify
    session.verify
  end
end
