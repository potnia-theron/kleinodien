module IngestionReflections
  class Archetype
    include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    attr_reader :factory

    def record_class = ::Archetype

    delegate_missing_to :record_class

    def after_belongs_to_associations(associations)
      associations.reject { |association| association.name == :archetypeable }
    end

    def after_has_many_associations(associations)
      associations.reject { |association| association.name == :editions }
    end

    def create_finder = factory.create_finder(::Archetype)
  end
end
