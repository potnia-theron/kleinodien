module IngestionReflections
    class EditionPosition < Base
    # include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    def record_class = ::EditionPosition

    delegate_missing_to :record_class

    def belongs_to_associations
      super.reject { it.name == :section }
    end

    def foreign_base_associations
      reflect_on_all_associations(:belongs_to)
        .select { it.name == :edition }
    end

    private

    attr_reader :factory
  end
end
