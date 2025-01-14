module LayeredImport
  class Buffer
    def initialize(order)
      @order = order
    end

    def buffered?(kind, code)
      fetch(kind, code) ? true : false
    end

    def fetch(kind, code, &block)
      kind, code = [kind.to_s, code.to_s]

      result = buffer.dig(kind, code)
      return result if result

      store(kind, code, block) if block

      buffer.dig(kind, code)
    end

    delegate :deep_dup, to: :buffer

    private

    attr_reader :order
    delegate :buffering?, to: :order

    def buffer
      @buffer ||= {}
    end

    def store(kind, code, block)
      raise "can't store unless \"buffering\"" unless buffering?

      buffer[kind] ||= {}
      buffer[kind][code] = block.call
    end
  end
end
