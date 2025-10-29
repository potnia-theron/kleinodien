module IngestionReflections
  class EditionSection
    include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    def record_class = ::EditionSection

    delegate_missing_to :record_class

    def belongs_to_associations
      super.reject { |association| association.name == :edition }
    end

    def inherent_attribute_names
      super.reject { |name| name == "positions_count" }
    end

    def create_finder = factory.create_finder(::EditionSection)

    private

    attr_reader :factory
  end
end
