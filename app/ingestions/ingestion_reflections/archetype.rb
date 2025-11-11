module IngestionReflections
  class Archetype < Default
    def record_class = ::Archetype

    delegate_missing_to :record_class

    def belongs_to_associations
      super.reject { it.name == :archetypeable }
    end

    def create_finder = factory.create_finder(::Archetype)
  end
end
