module LayeredImport
  class Timeout
    def initialize(calculator)
      @calculator = calculator
      @last = Time.zone.now.yesterday
    end

    def take(error_count)
      total_timeout = calculator.call(error_count)
      now = Time.zone.now
      actual_timeout = last + total_timeout - now
      sleep(actual_timeout) if actual_timeout.positive?

      @last = now
    end

    private

    attr_reader :calculator, :last
  end
end
