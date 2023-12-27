module Import
  class Buffer
    def buffered?(*)
      get(*) ? true : false
    end

    def dump
      buffer.deep_dup
    end

    def fetch(*, &block)
      store(*, block) if block
      get(*)
    end

    def get(*)
      kind, code = kind_code_to_s(*)
      buffer.dig(kind, code)
    end

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
