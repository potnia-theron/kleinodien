module IngestionReflections
  class Factory
    def initialize
      @cached_associations = {}
    end

    # the desired type may contain dashes ("-") e.g. "release-group"
    # so we need to to send #underscore to it
    def create(desired_type)
      "#{my_module}::#{desired_type.to_s.underscore.classify}"
        .constantize
        .new(self)
    end

    def create_associations(desired_type)
      record_class_name = desired_type.to_s.classify
      cached_associations[record_class_name] ||= associations_for(record_class_name, desired_type)
    end

    def create_finder(model_name) = finder_factory.create(model_name.to_s)

    attr_reader :import_order

    private

    attr_reader :cached_associations

    def associations_for(record_class_name, desired_type)
      class_name = "#{my_module}::Associations::#{record_class_name}"

      if (klass = class_name.safe_constantize)
        klass.new(self)
      else
        record_class = record_class_name.constantize
        Associations::Default.new(self, record_class)
      end
    end

    def finder_factory = @finder_factory ||= IngestionFinder::Factory.new

    def my_module = @my_module ||= self.class.name.sub(/::.+\z/, "")
  end
end
