module Import
  class Buffer
    def buffered?(kind, code)
      kind, code = kind_code_to_s(kind, code)

      return true if cache.dig(kind, code)
      false
    end

    def fetch(kind, code, &block)
      kind, code = kind_code_to_s(kind, code)
      store(kind, code, block.call) if block
      get(kind, code)
    end

    def get(*)
      kind, code = kind_code_to_s(*)
      cache.dig(kind, code)
    end

    private

    def cache
      @cache ||= {}
    end

    def kind_code_to_s(kind, code)
      [kind.to_s, code.to_s]
    end

    def store(kind, code, value)
      cache[kind] ||= {}
      cache[kind][code] = value
    end
  end
end
