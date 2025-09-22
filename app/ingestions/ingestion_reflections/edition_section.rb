module IngestionReflections
  class EditionSection
    include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    delegate_missing_to ::EditionSection

    def after_belongs_to_associations(associations)
      associations.reject { |association| association.name == :edition }
    end

    def after_inherent_attribute_names(names)
      names.reject { |name| name == "positions_count" }
    end

    # delegate :create_finder, to: :factory
    def create_finder = factory.create_finder(::EditionSection)

    private

    attr_reader :factory
  end
end
