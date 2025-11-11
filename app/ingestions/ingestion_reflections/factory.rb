module IngestionReflections
  class Factory
    def initialize
      @cached_associations = {}
      @cached_reflections = {}
    end

    # the desired type may contain dashes ("-") e.g. "release-group"
    # so we need to to send #underscore to it
    def create(desired_type)
      record_class_name = desired_type
        .to_s
        .underscore
        .classify

      cached_reflections[record_class_name] ||= reflections_for(record_class_name)
    end

    def create_associations(desired_type)
      record_class_name = desired_type.to_s.classify
      cached_associations[record_class_name] ||= associations_for(record_class_name, desired_type)
    end

    def create_finder(model_name) = finder_factory.create(model_name.to_s)

    private

    attr_reader :cached_associations, :cached_reflections

    def instance_for(class_name, fallback_class, record_class)
      (class_name.safe_constantize || fallback_class)
        .new(self, record_class)
    end

    def associations_for(record_class_name, desired_type)
      class_name = "#{my_module}::Associations::#{record_class_name}"
      record_class = record_class_name.constantize

      instance_for(class_name, Associations::Base, record_class)
    end

    def reflections_for(record_class_name)
      class_name = "#{my_module}::#{record_class_name}"
      record_class = record_class_name.constantize

      instance_for(class_name, Base, record_class)
    end

    def finder_factory = @finder_factory ||= IngestionFinder::Factory.new

    def my_module = @my_module ||= self.class.name.sub(/::.+\z/, "")

    def record_class_for(desired_type) = record_class_name_for(desired_type).constantize
  end
end
