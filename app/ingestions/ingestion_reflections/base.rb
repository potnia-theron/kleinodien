module IngestionReflections
  class Base
    def initialize(factory)
      @factory = factory
    end

    attr_reader :factory
    delegate :create, :create_associations, to: :factory
    delegate_missing_to :record_class

    def associations
      @associations ||= create_associations(record_class)
    end

    def create_finder
      factory.create_finder(model_name)
    end

    def inherent_attribute_names
      content_columns
        .map(&:name)
        .without("created_at", "updated_at")
    end

    def linkable?
      associations.reflect_on_all_associations(:has_many).any? { it.name == :links }
    end
  end
end
