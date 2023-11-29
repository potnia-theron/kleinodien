require "test_helper"
require "minitest/mock"

class Import::MusicbrainzInterrupterTest < ActiveSupport::TestCase
  setup do
    @response = Minitest::Mock.new
    @interrupter = Import::MusicbrainzInterrupter.new
  end

  test "#analze? with a failed response" do
    @response.expect :success?, false
    assert_not @interrupter.analyze? @response
    assert_equal @interrupter.errors, 1

    @response.verify
  end

  test "#analze? with a failed response followed by a successful response" do
    @response.expect :success?, false
    @interrupter.analyze? @response

    @response.expect :success?, true
    assert @interrupter.analyze? @response
    assert_equal @interrupter.errors, 0, "errors is set to 0"

    @response.verify
  end

  test "with failed responses" do
    3.times do
      @response.expect(:success?, false)
      @interrupter.analyze?(@response)
    end

    assert_equal @interrupter.errors, 3
  end
end
