module Import
  class Fetcher
    # def self.get(factory:, uri:)
    #   new(factory: factory, uri: uri).get
    # end

    def initialize(factory:, uri:)
      @factory = factory
      @ur = uri
    end

    def get
      max_tries.times do
        # TODO: response must accept uri
        response = connection.get # (uri)
        # TODO: don't return the body, instead call factory.purify(response)
        return response.body if response.success?
      end

      raise "can't get #{uri}"
    end

    private

    attr_reader :factory, :uri

    delegate_missing_to :factory
  end
end
