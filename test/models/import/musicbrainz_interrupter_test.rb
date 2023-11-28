require "test_helper"

class Import::MusicbrainzInterrupterTest < ActiveSupport::TestCase
  setup do
    @interrupter = Import::MusicbrainzInterrupter.new
  end

  # TODO: Add more meaningful tests
  test "methods" do
    assert_respond_to @interrupter, :analyze?
    assert_respond_to @interrupter, :perform
  end
end
