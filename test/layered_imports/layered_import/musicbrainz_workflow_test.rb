require "test_helper"
require "minitest/mock"

class LayeredImport::MusicbrainzWorkflowTest < ActiveSupport::TestCase
  test "xxx" do
    import_order = Minitest::Mock.new
    import_order.expect :buffering!, nil
    import_order.expect :buffered!, nil
    import_order.expect :persisting!, nil
    import_order.expect :persisted!, nil

    workflow = LayeredImport::MusicbrainzWorkflow.new(import_order)
    assert workflow.call

    import_order.verify
  end
end
