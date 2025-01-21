module LayeredImport
  class Timeout
    def initialize(calculator)
      @calculator = calculator
      @last = Time.zone.now.yesterday
    end

    def take
      sleep(interruption)
    end

    private

    attr_reader :calculator, :last

    def interruption
      calculator.call
    end
  end
end
