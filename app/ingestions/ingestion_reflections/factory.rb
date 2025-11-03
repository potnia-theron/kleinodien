module IngestionReflections
    class Factory < Base
    def create(desired_type)
      "#{my_module}::#{desired_type.to_s.underscore.classify}"
        .constantize
        .new(self)
    end

    def create_finder(model_name) = finder_factory.create(model_name.to_s)

    attr_reader :import_order

    private

    def finder_factory = @finder_factory ||= IngestionFinder::Factory.new

    def my_module = @my_module ||= self.class.name.sub(/::.+\z/, "")
  end
end
