module Import
  class Fetcher
    def initialize(factory:, uri:)
      @factory = factory
      @uri = uri
    end

    def get
      max_tries.times do
        response = attempt
        return parse(response) if response
      end

      raise "can't get #{uri}"
    end

    private

    attr_reader :factory, :uri

    def build_attempt
      factory.build_attempt
    end

    def max_tries
      factory.max_tries
    end

    def attempt
      attempt = build_attempt
      attempt.get(uri)
    end

    def parse(response)
      factory.transform_response(response)
    end
  end
end
