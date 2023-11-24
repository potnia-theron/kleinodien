module Import
  class FromHandler
    def initialize(factory)
      @factory = factory
    end

    def fetch(kind, code, &block)
      return factory.buffer.fetch(kind, code, &block) if block
      get(kind, code)
    end

    def get(kind, code)
      factory.buffer.get(kind, code)
    end

    private

    attr_reader :factory
  end
end
