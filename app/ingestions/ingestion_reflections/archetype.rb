module IngestionReflections
  class Archetype
    include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    def after_belongs_to_associations(associations)
      associations.reject { |association| association.name == :archetypeable }
    end

    def after_has_many_associations(associations)
      associations.reject { |association| association.name == :editions }
    end

    def create_finder = factory.create_finder(::Archetype)

    private

    attr_reader :factory
    delegate_missing_to ::Archetype
  end
end
