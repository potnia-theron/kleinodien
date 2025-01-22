require "test_helper"
require "minitest/mock"

class LayeredImport::MusicbrainzRequestLayerTest < ActiveSupport::TestCase
  setup do
    @order = Minitest::Mock.new
    @request_layer = LayeredImport::MusicbrainzRequestLayer.new(@order)
  end
end
