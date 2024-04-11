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

    def lock
      buffer.freeze
    end

    def locked?
      buffer.frozen?
    end

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
