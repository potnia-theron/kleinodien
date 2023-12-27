module Import
  class Buffer
    def buffered?(kind, code)
      kind, code = kind_code_to_s(kind, code)

      return true if buffer.dig(kind, code)
      false
    end

    def dump
      buffer.deep_dup
    end

    def fetch(kind, code, &block)
      kind, code = kind_code_to_s(kind, code)

      store(kind, code, block) if block
      get(kind, code)
    end

    def get(kind, code)
      kind, code = kind_code_to_s(kind, code)
      buffer.dig(kind, code)
    end

    private

    def buffer
      @buffer ||= {}
    end

    def kind_code_to_s(kind, code)
      [kind.to_s, code.to_s]
    end

    def store(kind, code, block)
      buffer[kind] ||= {}
      buffer[kind][code] = block.call
    end
  end
end
