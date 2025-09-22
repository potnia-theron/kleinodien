module IngestionFinder
  class NullFinder
    include Callable

    def call(_) = nil
  end
end
