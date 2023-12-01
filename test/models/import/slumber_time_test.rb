require "test_helper"
require "minitest/mock"

class Import::SlumberTimeTest < ActiveSupport::TestCase
  setup do
    @time_1970 = Time.zone.local(1970)
    @slumber_time = Import::SlumberTime.new(:fake_config_key, last_penalty_ends_at: @time_1970)
  end

  test "#calculate with success" do
    assert_equal @slumber_time.calculate(true), 1
  end

  test "calculate with error" do
    # @slumber_time.last is Time.zone.local(1970), current time should be
    # enought to result in a penalty-time of 0.
    assert_equal @slumber_time.calculate(false), 0 # errors == 1

    Time.stub :current, @time_1970 do
      # now: Thu, 01 Jan 1970 00:00:00.000000000 UTC +00:00
      assert_equal @slumber_time.calculate(false), 5 # errors == 2
    end

    t_1970_and_10s = @time_1970 + 10
    Time.stub :current, t_1970_and_10s do
      # last: Thu, 01 Jan 1970 00:00:12.000000000 UTC +00:00
      # now:  Thu, 01 Jan 1970 00:00:01.000000000 UTC +00:00
      assert_equal @slumber_time.calculate(false), 2 # errors == 3
    end
  end

  test "with a custom config" do
    import = Minitest::Mock.new
    import.expect :import, {test: {error_multiplier: 10, minimal_interruption: 10}}

    Rails.stub :configuration, import do
      @slumber_time = Import::SlumberTime.new(:test, last_penalty_ends_at: @time_1970)
    end

    Time.stub :current, @time_1970 do
      assert assert_equal @slumber_time.calculate(false), 110
    end

    import.verify
  end
end
