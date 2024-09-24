require "test_helper"
require "minitest/mock"

class TestFoo; end

module Import
  class MusicbrainzTestFooFacade
    def initialize(...)
    end

    def model_class = TestFoo
  end

  class FindTestFoo
    def initialize(...)
    end

    def call
      :called
    end
  end
end

class Import::MusicbrainzHandlerTest < ActiveSupport::TestCase
  test "with an ImportOrder" do
    import_order = Minitest::Mock.new
    import_order.expect :kind, "test_foo"
    import_order.expect :code, "c9994186-7659-11ef-b5d9-83803fcd2d52"

    handler = Import::MusicbrainzHandler.new(import_order)

    assert :called, handler.call

    import_order.verify
  end
end
