module IngestionReflections
  class Archetype
    include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    attr_reader :factory

    def record_class = ::Archetype

    delegate_missing_to :record_class

    def belongs_to_associations
      super.reject { it.name == :archetypeable }
    end

    def has_many_associations
      super.reject { it.name == :editions }
    end

    def create_finder = factory.create_finder(::Archetype)
  end
end
