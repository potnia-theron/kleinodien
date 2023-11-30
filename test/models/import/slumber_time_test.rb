require "test_helper"
require "minitest/mock"

class Import::SlumberTimeTest < ActiveSupport::TestCase
  setup do
    @slumber_time = Import::SlumberTime.new(:false_config)
    @time_1970 = Time.zone.local(1970)
  end

  test "#calculate with success" do
    assert_equal @slumber_time.calculate(true, :fake), 1
  end

  test "calculate with error" do
    assert_equal @slumber_time.calculate(false, @time_1970), 0 # errors == 1

    Time.stub :current, @time_1970 do
      assert_equal @slumber_time.calculate(false, @time_1970), 5 # errors == 2
    end

    Time.stub :current, @time_1970 do
      t_1970_and_1s = @time_1970 + 1
      assert_equal @slumber_time.calculate(false, t_1970_and_1s), 8 # errors == 3
    end
  end

  test "config" do
    # Minitest mocks seem not to work in a stub so we use a simple object
    import_config = {test: {error_multiplier: 10, minimal_interruption: 10}}

    import = Object.new
    import.define_singleton_method(:import) { import_config }

    Rails.stub :configuration, import do
      @slumber_time = Import::SlumberTime.new(:test)
    end

    Time.stub :current, @time_1970 do
      assert assert_equal @slumber_time.calculate(false, @time_1970), 110
    end
  end

  test "#penalty_time" do
    assert_equal @slumber_time.penalty_time, 0

    expected = [3, 5, 7]
    3.times do |i|
      @slumber_time.calculate(false, @time_1970)
      assert_equal @slumber_time.penalty_time, expected[i]
    end
  end
end
