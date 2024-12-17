module LayeredImport
  class ClockControl
    ONE_DAY = 86_400

    def initialize(fetch_layer)
      @fetch_layer = fetch_layer
      @errors = 0
      @last = Time.zone.now - ONE_DAY
    end

    attr_reader :errors, :fetch_layer, :last
    delegate_missing_to :fetch_layer

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
      total_timeout = calculate_total_timeout(errors)

      actual = last + total_timeout - now
      (actual > 0) ? actual : 0
    end

    def now
      Time.zone.now
    end
  end
end
