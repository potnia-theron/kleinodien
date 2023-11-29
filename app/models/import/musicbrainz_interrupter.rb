module Import
  class MusicbrainzInterrupter
    def initialize
      @errors = 0
    end

    attr_reader :errors

    def analyze?(response)
      if response.success?
        reset
        return true
      end

      @errors += 1
      false
    end

    def perform = nil

    private

    def reset
      @errors = 0
    end
  end
end
