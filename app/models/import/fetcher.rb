module Import
  class Fetcher
    def initialize(factory:, uri:)
      @factory = factory
      @uri = uri
    end

    def get
      max_tries.times do
        response = attempt.get(uri)
        return response if response
      end

      raise "can't get #{uri}"
    end

    private

    attr_reader :factory, :uri

    delegate_missing_to :factory
  end
end
