require "test_helper"
require "minitest/mock"

class Import::MusicbrainzRequestLayerTest < ActiveSupport::TestCase
  setup do
    @order = Minitest::Mock.new
    @request_layer = Import::MusicbrainzRequestLayer.new(@order)
  end
end
