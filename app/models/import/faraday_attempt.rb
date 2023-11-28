module Import
  class FaradayAttempt
    def initialize(factory)
      @factory = factory
    end

    def get(uri_string)
      interrupt
      @response = connection.get(uri_string)
      response if analyze?
    end

    private

    attr_reader :factory, :response

    def analyze?
      interrupter.analyze?(response)
    end

    def interrupt
      interrupter.perform
    end

    delegate_missing_to :factory
  end
end
