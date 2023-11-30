module Import
  class SlumberTime
    DEFAULT_CONFIG = {
      error_multiplier: 2,
      minimal_interruption: 1
    }.freeze

    def initialize(config_key, last_penalty_ends_at: Time.current)
      rails_config = Rails.configuration.import[config_key] || {}
      @config = DEFAULT_CONFIG.merge(rails_config).freeze
      @errors = 0
      @last_penalty_ends_at = last_penalty_ends_at
    end

    attr_reader :errors

    def calculate(success)
      if success
        @errors = 0
        return config[:minimal_interruption]
      end

      @errors += 1
      wake_up_in
    end

    private

    attr_reader :config, :last_penalty_ends_at

    def penalty_time
      return 0 if errors == 0

      error_multiplier = config[:error_multiplier]
      minimal_interruption = config[:minimal_interruption]

      minimal_interruption + errors * error_multiplier * minimal_interruption
    end

    def wake_up_in
      now = Time.current

      interruption_ends = last_penalty_ends_at + penalty_time
      return 0 if interruption_ends < now
      @last_penalty_ends_at = interruption_ends

      interruption_ends - now
    end
  end
end
