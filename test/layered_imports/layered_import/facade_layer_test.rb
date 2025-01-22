require "test_helper"
require "minitest/mock"

module LayeredImport
  class FacadeLayerTestName
    def name = "FacadeLayerTestFake"
  end

  class FacadeLayerTestReflections
    def base_class = FacadeLayerTestName.new
  end

  class DatasourceFacadeLayerTestFakeFacade
    def initialize(*)
    end
  end
end

class LayeredImport::FacadeLayerTest < ActiveSupport::TestCase
  test "#build_facade" do
    order = Minitest::Mock.new
    facade_layer = LayeredImport::FacadeLayer.new(order)

    order.expect :class_name_component, "Datasource"

    facade = facade_layer.build_facade(LayeredImport::FacadeLayerTestReflections.new, {})
    assert_instance_of LayeredImport::DatasourceFacadeLayerTestFakeFacade, facade
  end
end
