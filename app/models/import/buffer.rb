module Import
  class Buffer
    def buffered?(kind, code)
      fetch(kind, code) ? true : false
    end

    def fetch(kind, code, &block)
      kind, code = [kind.to_s, code.to_s]

      store(kind, code, block) if block
      buffer.dig(kind, code)
    end

    delegate :deep_dup, to: :buffer
    # #freeze must be delegated to the buffer.
    # Otherwise lazy loading will not work.
    delegate :freeze, to: :buffer
    delegate :frozen?, to: :buffer

    private

    def buffer
      @buffer ||= {}
    end

    def store(kind, code, block)
      buffer[kind] ||= {}
      buffer[kind][code] = block.call
    end
  end
end
