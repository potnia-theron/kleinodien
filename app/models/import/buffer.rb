module Import
  class Buffer
    def initialize(order)
      @order = order
    end

    def buffered?(uri_string)
      fetch(uri_string) ? true : false
    end

    def fetch(uri_string, &block)
      buffer[uri_string] || block && store(uri_string, block)
    end

    delegate :deep_dup, to: :buffer

    private

    attr_reader :order
    delegate :buffering?, to: :order

    def buffer
      @buffer ||= {}
    end

    def store(uri_string, block)
      raise "can't store unless \"buffering\"" unless buffering?

      buffer[uri_string] = block.call
    end
  end
end
