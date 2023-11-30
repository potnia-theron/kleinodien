module Import
  class SlumberTime
    DEFAULT_CONFIG = {
      error_multiplier: 2,
      minimal_interruption: 1
    }.freeze

    def initialize(config_key)
      rails_config = Rails.configuration.import[config_key] || {}
      @config = DEFAULT_CONFIG.merge(rails_config).freeze
      @errors = 0
    end

    attr_reader :errors

    def calculate(success, last)
      if success
        @errors = 0
        return config[:minimal_interruption]
      end

      @errors += 1
      now = Time.current

      interruption_ends = last + penalty_time
      return 0 if interruption_ends < now
      interruption_ends - now
    end

    def penalty_time
      return 0 if errors == 0

      error_multiplier = config[:error_multiplier]
      minimal_interruption = config[:minimal_interruption]

      minimal_interruption + errors * error_multiplier * minimal_interruption
    end

    private

    attr_reader :config
  end
end
