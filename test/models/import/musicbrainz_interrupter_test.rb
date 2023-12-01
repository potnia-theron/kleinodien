require "test_helper"
require "minitest/mock"

class Import::MusicbrainzInterrupterTest < ActiveSupport::TestCase
  setup do
    @response = Minitest::Mock.new
    @interrupter = Import::MusicbrainzInterrupter.new(:fake_slumber)
  end

  test "#analze? with a failed response" do
    @response.expect :success?, false
    assert_not @interrupter.analyze? @response

    @response.verify
  end

  test "#analze? with a failed response followed by a successful response" do
    @response.expect :success?, false
    @interrupter.analyze? @response

    @response.expect :success?, true
    assert @interrupter.analyze? @response

    @response.verify
  end

  test "with failed responses" do
    3.times do
      @response.expect(:success?, false)
      @interrupter.analyze?(@response)
    end
  end

  test "private #slumber - ensures that #slumber is called at least one time" do
    import = Minitest::Mock.new
    import.expect :import, {musicbrainz: {skip_sleep: false}}

    slumber = Minitest::Mock.new

    Rails.stub :configuration, import do
      slumber.expect :calculate, 0, [false]

      @interrupter = Import::MusicbrainzInterrupter.new(slumber)
      assert_equal @interrupter.perform, 0
    end

    import.verify
    slumber.verify
  end
end
