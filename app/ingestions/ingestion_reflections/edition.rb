module IngestionReflections
  class Edition < Base
    def record_class = ::Edition

    def create_finder = IngestionFinder::Edition.new
  end
end
