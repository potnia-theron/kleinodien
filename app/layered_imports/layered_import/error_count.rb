module LayeredImport
  class ErrorCount
    def initialize
      @count = 0
    end

    attr_reader :count

    def up
      @count += 1
    end

    def resest
      @count = 0
    end
  end
end
