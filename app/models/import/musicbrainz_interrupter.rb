module Import
  class MusicbrainzInterrupter
    def initialize(slumber_time = Import::SlumberTime.new(:musicbrainz))
      @slumber_time = slumber_time
      @success = false
    end

    def analyze?(response)
      @success = response.success?
    end

    def perform
      slumber_time = calculate_slumber_time

      return slumber_time if config[:skip_sleep]

      slumber(slumber_time)
    end

    private

    attr_reader :slumber_time, :success

    def calculate_slumber_time
      slumber_time.calculate(success)
    end

    def config
      @config ||= Rails.configuration.import[:musicbrainz]
    end

    def slumber(slumber_time)
      sleep(slumber_time)
      slumber_time
    end
  end
end
