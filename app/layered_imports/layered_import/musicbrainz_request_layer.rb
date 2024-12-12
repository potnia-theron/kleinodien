module LayeredImport
  class MusicbrainzRequestLayer
    def initialize(order)
      @order = order
    end

    attr_reader :order

    def get(kind, code)
      {}
    end
  end
end
