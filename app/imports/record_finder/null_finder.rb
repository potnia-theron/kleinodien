module RecordFinder
  class NullFinder
    include Callable

    def call(_) = nil
  end
end
