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

    private

    def buffer
      @buffer ||= {}
    end

    def kind_code_to_s(kind, code)
      [kind.to_s, code.to_s]
    end

    def store(*, block)
      kind, code = kind_code_to_s(*)
      buffer[kind] ||= {}
      buffer[kind][code] = block.call
    end
  end
end
