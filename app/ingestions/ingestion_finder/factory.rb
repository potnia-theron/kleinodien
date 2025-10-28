module IngestionFinder
  class Factory
    def initialize
      @cache = {}
    end

    def create(model_class)
      finder_for("IngestionFinder::#{model_class}")
    end

    private

    attr_reader :cache

    def finder_for(class_name)
      cache[class_name] ||= (class_name.safe_constantize || IngestionFinder::NullFinder).new
      cache[class_name]
    end
  end
end
