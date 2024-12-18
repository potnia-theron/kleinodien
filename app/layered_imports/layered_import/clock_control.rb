module LayeredImport
  class ClockControl
    ONE_DAY = 86_400

    def initialize(timeout_calculator)
      @timeout_calculator = timeout_calculator
      @errors = 0
      @last = Time.zone.now - ONE_DAY
    end

    attr_reader :errors, :last, :timeout_calculator

    def schedule &block
      timeout

      result = block.call

      @errors = result ? 0 : errors + 1

      result
    end

    def timeout
      sleep actual_timeout

      @errors = 0
      @last = now

      nil
    end

    private

    def actual_timeout
      (last + total_timeout - now)
        .then { |actual| [actual, 0].max } # ensure actual_timeout >= 0
    end

    def now = Time.zone.now

    def total_timeout = timeout_calculator.call(errors)
  end
end
