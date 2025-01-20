module LayeredImport
  class ClockControl
    def initialize(response_validator, timeout_calculator)
      @response_validator = response_validator
      @timeout_calculator = timeout_calculator
      @errors = 0
      @last = Time.zone.now.yesterday
    end

    attr_reader :errors, :last, :response_validator, :timeout_calculator

    def schedule &block
      timeout

      response = block.call

      if response_validator.call(response)
        @errors = 0
        response
      else
        @errors += 1
        nil
      end
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
