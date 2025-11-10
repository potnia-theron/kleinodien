module IngestionReflections
  class EditionSection < Base
    def record_class = ::EditionSection

    delegate_missing_to :record_class

    def belongs_to_associations
      super.reject { it.name == :edition }
    end

    def inherent_attribute_names
      super.reject { it == "positions_count" }
    end

    def create_finder = factory.create_finder(::EditionSection)
  end
end
